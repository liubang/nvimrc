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
  { "mason-org/mason-lspconfig.nvim" },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonUpdate" },
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:nvim-java/mason-registry",
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
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = {
          "clangd",
          "gopls",
          "lua_ls",
          "jdtls",
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
        debug = false,
        sources = {
          b.formatting.stylua,
          b.formatting.asmfmt,
          b.formatting.buildifier,
          b.formatting.prettier.with({
            filetypes = {
              "css",
              "graphql",
              "handlebars",
              "html",
              "javascript",
              "javascriptreact",
              "json",
              "jsonc",
              "less",
              "markdown",
              "markdown.mdx",
              "scss",
              "typescript",
              "typescriptreact",
              "vue",
              "yaml",
            },
          }),
          b.formatting.shfmt.with({
            extra_args = { "-i", "4", "-ci", "-bn" },
          }),
          b.formatting.sql_formatter.with({
            extra_args = {
              "--config=" .. vim.fn.stdpath("config") .. "/data/sql-formatter/sql-formatter.json",
            },
          }),
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
