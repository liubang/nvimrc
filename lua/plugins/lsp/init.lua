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
    "mason-org/mason-lspconfig.nvim",
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonUpdate" },
    opts = {
      github = {
        download_url_template = "https://ghfast.top/https://github.com/%s/releases/download/%s/%s",
      },
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
    "nvim-java/nvim-java",
    config = function()
      local java = require("java")

      local override_setup = function()
        -- Override the nvim-java setup function in order to allow following the latest dependency versions (jdtls, ...)
        local custom_config = {
          java_debug_adapter = {
            enable = false,
          },
          jdk = {
            auto_install = false,
          },
        }
        local decomple_watch = require("java.startup.decompile-watcher")
        local setup_wrap = require("java.startup.lspconfig-setup-wrap")
        -- local dap_api = require("java.api.dap")
        local global_config = require("java.config")
        vim.api.nvim_exec_autocmds("User", { pattern = "JavaPreSetup" })
        local config = vim.tbl_deep_extend("force", global_config, custom_config or {})
        vim.g.nvim_java_config = config
        vim.api.nvim_exec_autocmds("User", { pattern = "JavaSetup", data = { config = config } })
        setup_wrap.setup(config)
        decomple_watch.setup()
        -- dap_api.setup_dap_on_lsp_attach()
        vim.api.nvim_exec_autocmds("User", { pattern = "JavaPostSetup", data = { config = config } })
      end

      java.setup = override_setup
      java.setup()
    end,
    dependencies = {
      {
        "nvim-java/nvim-java-core",
        url = "https://github.com/Kabil777/nvim-java-core.git",
        branch = "fix/mason-api-update",
      },
    },
  },
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
      "nvim-java/nvim-java",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = {
          "clangd",
          "gopls",
          "pyright",
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
