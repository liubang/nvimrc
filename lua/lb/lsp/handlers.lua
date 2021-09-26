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
