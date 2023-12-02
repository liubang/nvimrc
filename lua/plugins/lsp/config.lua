-- =====================================================================
--
-- config.lua -
--
-- Created by liubang on 2021/02/10 10:06
-- Last Modified: 2022/12/10 15:54
--
-- =====================================================================

local config = require("lb.config")

vim.lsp.set_log_level("OFF")

vim.diagnostic.config({ -- {{{
  source = true,
  signs = true,
  virtual_text = false,
  severity_sort = true,
  update_in_insert = false,
  underline = false,
  float = {
    border = "single",
    focusable = true,
    header = " Diagnostics: ",
    scope = "line",
    source = "always",
  },
}) -- }}}

local dia_cfg = config.lsp.diagnostic
local hl = "DiagnosticSign"
local nr = "DiagnosticLineNr"
vim.fn.sign_define(hl .. "Error", { text = dia_cfg.icons.Error, texthl = hl .. "Error", numhl = nr .. "Error" })
vim.fn.sign_define(hl .. "Warn", { text = dia_cfg.icons.Warn, texthl = hl .. "Warn", numhl = nr .. "Warn" })
vim.fn.sign_define(hl .. "Info", { text = dia_cfg.icons.Info, texthl = hl .. "Info", numhl = nr .. "Info" })
vim.fn.sign_define(hl .. "Hint", { text = dia_cfg.icons.Hint, texthl = hl .. "Hint", numhl = nr .. "Hint" })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { -- {{{
  stylize_markdown = true,
  syntax = "lsp_markdown",
  border = "single",
}) -- }}}

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { -- {{{
  border = "single",
  focusable = false,
  relative = "cursor",
}) -- }}}

--
-- auto cmd
--
local lsp_events_group = vim.api.nvim_create_augroup("LSP_EVENTS", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_events_group,
  pattern = "*.go",
  callback = function()
    local client = function()
      return vim.lsp.get_active_clients({ name = "gopls" })
    end
    require("plugins.lsp.utils").codeaction(client(), "", "source.organizeImports", 1000)
    require("plugins.lsp.format").format()
  end,
})

-- vim: foldmethod=marker foldlevel=0
