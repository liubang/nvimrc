-- =====================================================================
--
-- handlers.lua -
--
-- Created by liubang on 2021/02/10 10:06
-- Last Modified: 2021/02/10 10:06
--
-- =====================================================================
vim.lsp.handlers['textDocument/definition'] = function(_, result)
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

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  require('lsp_extensions.workspace.diagnostic').handler,
  {
    signs = {
      severity_limit = 'Error',
    },
    underline = {
      severity_limit = 'Warning',
    },
    virtual_text = false,
  }
)

vim.lsp.handlers['textDocument/hover'] = require('lspsaga.hover').handler

local ns_rename = vim.api.nvim_create_namespace 'lb_rename'

MyLspRename = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_rename, 0, -1)
  local current_word = vim.fn.expand '<cword>'
  local plenary_window = require('plenary.window.float').percentage_range_window(0.5, 0.2)
  vim.api.nvim_buf_set_option(plenary_window.bufnr, 'buftype', 'prompt')
  vim.fn.prompt_setprompt(plenary_window.bufnr, string.format('Rename "%s" to > ', current_word))
  vim.fn.prompt_setcallback(plenary_window.bufnr, function(text)
    vim.api.nvim_win_close(plenary_window.win_id, true)
    if text ~= '' then
      vim.schedule(function()
        vim.api.nvim_buf_delete(plenary_window.bufnr, { force = true })
        vim.lsp.buf.rename(text)
      end)
    else
      print 'Nothing to rename!'
    end
  end)
  vim.cmd [[startinsert]]
end

-- golang organize imports
GoOrgImports = function(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local method = 'textDocument/codeAction'
  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit)
    end
  end
  vim.lsp.buf.formatting_sync()
end
