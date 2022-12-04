-- =====================================================================
--
-- handlers.lua -
--
-- Created by liubang on 2021/02/10 10:06
-- Last Modified: 2022/12/01 22:43
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
    border = "single",
    focusable = true,
    header = "  Diagnostics: ",
    scope = "line",
    source = "always",
  },
}

local signs = {
  Error = "🔥",
  Warn = "💩",
  Info = "💬",
  Hint = "💡",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  local nr = "DiagnosticLineNr" .. type
  vim.fn.sign_define(hl, {
    text = icon,
    texthl = hl,
    linehl = "",
    numhl = nr,
  })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  stylize_markdown = true,
  syntax = "lsp_markdown",
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single",
})
