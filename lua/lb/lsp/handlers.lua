-- =====================================================================
--
-- handlers.lua -
--
-- Created by liubang on 2021/02/10 10:06
-- Last Modified: 2021/02/10 10:06
--
-- =====================================================================

vim.diagnostic.config {
  source = true,
  signs = true,
  virtual_text = false,
  severity_sort = true,
  update_in_insert = false,
  underline = false,
  float = {
    border = 'single',
    focusable = false,
    header = '  Diagnostics: ',
    scope = 'line',
    source = true,
  },
}

vim.lsp.handlers['textDocument/definition'] = function(_, result)
  if not result or vim.tbl_isempty(result) then
    print '[LSP] Could not find definition'
    return
  end
  local enc = vim.lsp.util._get_offset_encoding(0)
  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1], enc)
  else
    vim.lsp.util.jump_to_location(result, enc)
  end
end

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'single',
})

-- golang organize imports
GoOrgImports = function(timeoutms)
  local context = { source = { organizeImports = true } }
  local enc = vim.lsp.util._get_offset_encoding(0)
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params(0, enc)
  params.context = context
  local method = 'textDocument/codeAction'
  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit, enc)
    end
  end

  vim.lsp.buf.formatting_sync(nil, 3000)
end
