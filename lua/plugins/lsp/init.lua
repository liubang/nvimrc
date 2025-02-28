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
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate" },
    build = ":MasonUpdate",
    opts = {
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
      github = {
        download_url_template = "https://ghfast.top/https://github.com/%s/releases/download/%s/%s",
      },
      ui = {
        border = "single",
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " ",
        },
      },
    },
  },
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "nvim-java/nvim-java-refactor",
    },
  },
  { "b0o/schemastore.nvim" },
  { "simrat39/rust-tools.nvim" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      {
        "p00f/clangd_extensions.nvim",
        opts = {
          inlay_hints = {
            inline = false,
          },
          memory_usage = {
            border = "single",
          },
          symbol_info = {
            border = "single",
          },
        },
      },
    },
    config = function()
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      if have_mason then
        mlsp.setup({
          ensure_installed = {
            "clangd",
            "gopls",
            "lua_ls",
            "rust_analyzer",
          },
        })
      end
      -- It's important that you set up the plugins in the following order:
      -- 1. mason.nvim
      -- 2. mason-lspconfig.nvim
      -- Setup servers via lspconfig
      require("plugins.lsp.config")
      require("plugins.lsp.servers")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      local b = null_ls.builtins
      local c = require("plugins.lsp.customs")
      return c.default({
        debug = true,
        sources = {
          b.formatting.stylua,
          b.formatting.cmake_format,
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
      })
    end,
  },
}

-- vim: fdm=marker fdl=0
