-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

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

local popup_window = {
  stylize_markdown = true,
  syntax = "lsp_markdown",
  border = "single",
  width = 100,
  height = 10,
  max_height = 20,
  max_width = 140,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, popup_window)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, popup_window)

--
-- auto cmd
--
local lsp_events_group = vim.api.nvim_create_augroup("LSP_EVENTS", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = lsp_events_group,
  pattern = "*.go",
  callback = function()
    local client = function()
      local get_clients = (
        vim.lsp.get_clients ~= nil and vim.lsp.get_clients -- nvim 0.10+
        or vim.lsp.get_active_clients
      )
      return get_clients({ name = "gopls" })
    end
    require("plugins.lsp.utils").codeaction(client(), "", "source.organizeImports", 1000)
    require("plugins.lsp.format").format()
  end,
})

-- vim: foldmethod=marker foldlevel=0
