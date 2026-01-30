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

-- vim.lsp.set_log_level("TRACE")

vim.diagnostic.config({ -- {{{
  source = true,
  signs = true,
  virtual_text = false,
  severity_sort = true,
  update_in_insert = false,
  underline = false,
  float = {
    spacing = 4,
    border = nil,
    focusable = true,
    header = " Diagnostics: ",
    scope = "line",
    source = true,
  },
}) -- }}}

vim.lsp.handlers["textDocument/documentHighlight"] = function() end

--
-- auto cmd
--
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local bufopts = { noremap = true, silent = true, buffer = event.buf }
    -- common keymaps
    vim.keymap.set("n", "<Leader>gd", "<cmd>Telescope lsp_definitions<CR>", bufopts)
    vim.keymap.set("n", "<Leader>gi", "<cmd>Telescope lsp_implementations<CR>", bufopts)
    vim.keymap.set("n", "<Leader>gr", "<cmd>Telescope lsp_references<CR>", bufopts)
    vim.keymap.set("n", "<Leader>gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)

    vim.keymap.set("n", "<C-k>", function()
      vim.lsp.buf.hover({
        height = 15,
        width = 100,
        max_height = 20,
        max_width = 140,
      })
    end, bufopts)
    vim.keymap.set("n", "<C-h>", function()
      vim.lsp.buf.signature_help({
        height = 15,
        width = 100,
        max_height = 20,
        max_width = 140,
      })
    end, bufopts)

    require("plugins.lsp.format").on_attach(nil, event.buf)
  end,
})

local group = vim.api.nvim_create_augroup("LSP_EVENTS", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*.go",
  callback = function()
    require("lb.utils.util").codeaction(vim.lsp.get_clients({ name = "gopls" })[1], "", "source.organizeImports", 1000)
    require("plugins.lsp.format").format()
  end,
})

-- vim: foldmethod=marker foldlevel=0
