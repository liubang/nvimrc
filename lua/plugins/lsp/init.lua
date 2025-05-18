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

return {
  {
    "williamboman/mason-lspconfig.nvim",
    -- version = "^1.0.0",
  },
  {
    "mason-org/mason.nvim",
    -- version = "^1.0.0",
    cmd = { "Mason", "MasonUpdate" },
    opts = {
      github = {
        download_url_template = "https://ghfast.top/https://github.com/%s/releases/download/%s/%s",
      },
      ui = {
        border = "single",
        -- stylua: ignore
        icons = {
          package_pending     = " ",
          package_installed   = "󰄳 ",
          package_uninstalled = " ",
        },
      },
    },
  },
  { "b0o/schemastore.nvim" },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = {
          "clangd",
          "gopls",
          "pyright",
          "lua_ls",
        },
      })
      -- It's important that you set up the plugins in the following order:
      -- 1. mason.nvim
      -- 2. mason-lspconfig.nvim
      -- Setup servers via lspconfig
      _ = require("plugins.lsp.config")
      _ = require("plugins.lsp.servers")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      local b = null_ls.builtins
      return {
        debug = true,
        sources = {
          b.formatting.stylua,
          b.formatting.asmfmt,
          b.formatting.buildifier,
          b.formatting.prettier.with({
            filetypes = {
              "css",
              "scss",
              "less",
              "html",
              "json",
              "jsonc",
              "yaml",
              "markdown",
              "markdown.mdx",
              "graphql",
              "handlebars",
            },
          }),
          b.formatting.shfmt,
          b.code_actions.gomodifytags,
          b.code_actions.impl,
          b.diagnostics.buildifier,
          b.diagnostics.actionlint,
        },
      }
    end,
  },
}

-- vim: fdm=marker fdl=0
