--=====================================================================
--
-- null-ls.lua -
--
-- Created by liubang on 2022/08/06 00:13
-- Last Modified: 2022/08/06 00:13
--
--=====================================================================

-- vim.cmd.packadd "null-ls.nvim"

local null_ls = require "null-ls"
local b = null_ls.builtins
local M = {}

local sources = {
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
}

M.setup = function()
  null_ls.setup {
    debug = true,
    on_attach = require("plugins.lsp.customs").default({}).on_attach,
    sources = sources,
  }
end

return M
