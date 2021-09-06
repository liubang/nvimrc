-- =====================================================================
--
-- handlers.lua -
--
-- Created by liubang on 2021/02/10 10:06
-- Last Modified: 2021/02/10 10:06
--
-- =====================================================================
-- LuaFormatter off
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false,
  }
)

vim.lsp.handlers['textDocument/definition'] = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    print '[LSP] Could not find definition'
    return
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1])
  else
    vim.lsp.util.jump_to_location(result)
  end
end

vim.lsp.handlers['textDocument/hover'] = require('lspsaga.hover').handler
-- LuaFormatter on

local ns_rename = vim.api.nvim_create_namespace 'lb_rename'

MyLspRename = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_rename, 0, -1)
  local current_word = vim.fn.expand '<cword>'
  local saga = require 'lspsaga.rename'
  local line, col = vim.fn.line '.', vim.fn.col '.'
  local contents = vim.api.nvim_buf_get_lines(bufnr, line - 1, line, false)[1]
  local has_found_highlights, start, finish = false, 0, -1
  while not has_found_highlights do
    start, finish = contents:find(current_word, start + 1, true)
    if not start or not finish then
      break
    end

    if start <= col and finish >= col then
      has_found_highlights = true
    end
  end

  if has_found_highlights then
    vim.api.nvim_buf_add_highlight(bufnr, ns_rename, 'Visual', line - 1, start - 1, finish)
    vim.cmd(
      string.format(
        'autocmd BufEnter <buffer=%s> ++once :call nvim_buf_clear_namespace(%s, %s, 0, -1)',
        bufnr,
        bufnr,
        ns_rename
      )
    )
  end

  saga.rename()

  vim.api.nvim_buf_set_keymap(
    0,
    'n',
    '<esc>',
    '<cmd>lua require("lspsaga.rename").close_rename_win()<CR>',
    { noremap = true, silent = true }
  )
  return
end

-- golang organize imports
GoOrgImports = function(_, timeout_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { 'source.organizeImports' } }
  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, timeout_ms)
  if not result or next(result) == nil then
    -- log 'nil result'
    print 'nil result'
    return
  end
  for _, res in pairs(result) do
    for _, r in pairs(res.result or {}) do
      if r.edit or type(r.command) == 'table' then
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit)
        end
        if type(r.command) == 'table' then
          vim.lsp.buf.execute_command(r.command)
        end
      else
        vim.lsp.buf.execute_command(r)
      end
    end
  end
  vim.lsp.buf.formatting()
end

-- java organize imports
local function within_range(outer, inner)
  local o1y = outer.start.line
  local o1x = outer.start.character
  local o2y = outer['end'].line
  local o2x = outer['end'].character
  assert(o1y <= o2y, 'Start must be before end: ' .. vim.inspect(outer))

  local i1y = inner.start.line
  local i1x = inner.start.character
  local i2y = inner['end'].line
  local i2x = inner['end'].character
  assert(i1y <= i2y, 'Start must be before end: ' .. vim.inspect(inner))

  -- Outer: {}
  -- Inner: []
  -------------
  -------------
  --  {     [ ]
  --      }
  -------------
  --     {
  --  []   }
  -------------

  if o1y < i1y then
    --     {
    --  [      ]
    --     }
    if o2y > i2y then
      return true
    end
    --     {
    --  [  }   ]
    return o2y == i2y and o2x >= i2x
  elseif o1y == i1y then
    if o2y > i2y then
      -- { []
      --  }
      return true
    else
      --  { [ ]  }
      --  [ { ]  }
      return o2y == i2y and o1x <= i1x and o2x >= i2x
    end
  else
    return false
  end
end

local function get_diagnostics_for_range(bufnr, range)
  local diagnostics = vim.lsp.diagnostic.get(bufnr)
  if not diagnostics then
    return {}
  end
  local line_diagnostics = {}
  for _, diagnostic in ipairs(diagnostics) do
    if within_range(diagnostic.range, range) then
      table.insert(line_diagnostics, diagnostic)
    end
  end
  if #line_diagnostics == 0 then
    -- If there is no diagnostics at the cursor position,
    -- see if there is at least something on the same line
    for _, diagnostic in ipairs(diagnostics) do
      if diagnostic.range.start.line == range.start.line then
        table.insert(line_diagnostics, diagnostic)
      end
    end
  end
  return line_diagnostics
end

local java_action_organize_imports = function()
  local params = vim.lsp.util.make_range_params()
  params.context = {
    diagnostics = get_diagnostics_for_range(vim.api.nvim_get_current_buf(), params.range),
  }
  vim.lsp.buf_request(0, 'java/organizeImports', params, function(err, _, resp)
    if err then
      print('Error on organize imports: ' .. err.message)
      return
    end
    if resp then
      vim.lsp.util.apply_workspace_edit(resp)
    end
  end)
end

JavaOrgImports = java_action_organize_imports

local java_generate_to_string_prompt = function()
  vim.lsp.buf_request(0, 'java/checkToStringStatus', {}, function(err, _, result)
    if err then
      print('Could not execute java/checkToStringStatus: ' .. err.message)
      return
    end
    if not result then
      return
    end
    if result.exists then
      vim.cmd 'redraw! | echo | redraw!'
      local actions = { 'Yes', 'No' }
      local section = vim.fn.confirm(
        'Method \'toString()\' already exists. Do you want to replace it?',
        '&Yes\n&No'
      )
      vim.cmd 'redraw!'
      if section == 2 then
        return
      end
    end
    vim.lsp.buf_request(
      0,
      'java/generateToString',
      { context = {}, fields = result.fields },
      function(e, _, edit)
        if e then
          print('Could not execute java/generateToString: ' .. e.message)
          return
        end
        if edit then
          vim.lsp.util.apply_workspace_edit(edit)
        end
      end
    )
  end)
end

local java_action_rename = function() end

local java_apply_workspace_edit = function() end

local java_hash_code_equals_prompt = function() end

local java_apply_refactoring_command = function() end

local java_choose_imports = function() end

local java_generate_constructors_prompt = function() end

local java_generate_delegate_methods_prompt = function() end

local M = {}

M.commands = {
  ['java.apply.workspaceEdit'] = java_apply_workspace_edit,
  ['java.action.generateToStringPrompt'] = java_generate_to_string_prompt,
  ['java.action.hashCodeEqualsPrompt'] = java_hash_code_equals_prompt,
  ['java.action.applyRefactoringCommand'] = java_apply_refactoring_command,
  ['java.action.rename'] = java_action_rename,
  ['java.action.organizeImports'] = java_action_organize_imports,
  ['java.action.organizeImports.chooseImports'] = java_choose_imports,
  ['java.action.generateConstructorsPrompt'] = java_generate_constructors_prompt,
  ['java.action.generateDelegateMethodsPrompt'] = java_generate_delegate_methods_prompt,
}

return M
