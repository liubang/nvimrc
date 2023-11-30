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
        mlsp.setup({ ensure_installed = { "clangd", "gopls", "lua_ls", "rust_analyzer" } })
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
          b.formatting.fixjson,
          b.formatting.latexindent.with({
            args = {
              "-g",
              "/dev/null",
              "-y",
              [[defaultIndent: "    "]],
            },
          }),
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
          b.formatting.eslint_d.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
            },
          }),
          b.formatting.shfmt,
          b.diagnostics.shellcheck,
          b.diagnostics.buildifier,
          b.diagnostics.actionlint,
          b.diagnostics.eslint_d,
        },
      })
    end,
  },
}

-- vim: fdm=marker fdl=0
