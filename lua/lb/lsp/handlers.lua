-- =====================================================================
--
-- handlers.lua -
--
-- Created by liubang on 2021/02/10 10:06
-- Last Modified: 2021/02/10 10:06
--
-- =====================================================================

vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
}

vim.lsp.handlers['textDocument/definition'] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print '[LSP] Could not find definition'
    return
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], 'utf-16')
  else
    vim.lsp.util.jump_to_location(result, 'utf-16')
  end
end

-- golang organize imports
GoOrgImports = function(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params(0, 'utf-16')
  params.context = context
  local method = 'textDocument/codeAction'
  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit, 'utf-16')
    end
  end

  vim.defer_fn(function()
    vim.lsp.buf.formatting_sync(nil, 1000)
  end, 1000)
end
