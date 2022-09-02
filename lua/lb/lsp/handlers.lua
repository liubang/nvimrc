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
