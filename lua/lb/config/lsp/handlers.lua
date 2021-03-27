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
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true, 
    underline = true,
    signs = true, 
    update_in_insert = false
  })

vim.lsp.handlers['textDocument/definition'] = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    print("[LSP] Could not find definition")
    return
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.jump_to_location(result[1])
  else
    vim.lsp.util.jump_to_location(result)
  end
end
-- LuaFormatter on
