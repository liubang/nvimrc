-- =====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/02/06 00:10
-- Last Modified: 2023/02/09 00:43
--
-- =====================================================================

return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate" },
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "single",
      },
    },
  },
  { "b0o/schemastore.nvim" },
  { "simrat39/rust-tools.nvim" },
  { "jose-elias-alvarez/typescript.nvim" },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
    },
    config = function()
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      if have_mason then
        mlsp.setup { ensure_installed = { "clangd", "gopls", "lua_ls", "rust_analyzer" } }
      end
      -- It's important that you set up the plugins in the following order:
      -- 1. mason.nvim
      -- 2. mason-lspconfig.nvim
      -- Setup servers via lspconfig
      require "plugins.lsp.handlers"
      require "plugins.lsp.servers"
      require "plugins.lsp.autocmd"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require "null-ls"
      local b = null_ls.builtins
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          b.formatting.buf,
          b.formatting.phpcsfixer,
          b.formatting.stylua,
          b.formatting.cmake_format,
          b.formatting.asmfmt,
          b.formatting.buildifier,
          b.formatting.fixjson,
          b.formatting.autopep8,
          b.formatting.latexindent.with {
            args = {
              "-g",
              "/dev/null",
              "-y",
              [[defaultIndent: "    "]],
            },
          },
          b.formatting.prettier.with {
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
          },
          b.formatting.eslint_d.with {
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
            },
          },
          b.formatting.shfmt.with {
            extra_args = { "-i", "2", "-ci" },
          },
          b.diagnostics.buf.with {
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          },
          b.diagnostics.shellcheck.with {
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          },
          b.diagnostics.buildifier.with {
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          },
          b.diagnostics.actionlint.with {
            method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
          },
          b.diagnostics.eslint_d,
        },
      }
    end,
  },
}

-- vim: fdm=marker fdl=0
