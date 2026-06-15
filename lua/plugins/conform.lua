-- Copyright (c) 2026 The Authors. All rights reserved.
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
-- Created: 2026/06/14 16:58

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<Leader>fm",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    default_format_opts = { stop_after_first = true },
    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      if ft == "go" then
        local gopls = vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" })[1]
        if gopls then
          require("venux.utils.util").codeaction(gopls, "", "source.organizeImports", 1000)
        end
        return { timeout_ms = 500, lsp_format = "fallback" }
      end
      if ft == "lua" then
        return { timeout_ms = 500, lsp_format = "fallback" }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      asm = { "asmfmt" },
      bzl = { "buildifier" },
      go = { "gofumpt" },
      css = { "prettier" },
      graphql = { "prettier" },
      handlebars = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      less = { "prettier" },
      markdown = { "prettier" },
      mdx = { "prettier" },
      scss = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      yaml = { "prettier" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      sql = { "sql_formatter" },
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "4", "-ci", "-bn" },
      },
      sql_formatter = {
        prepend_args = {
          "--config=" .. vim.fn.stdpath("config") .. "/data/sql-formatter/sql-formatter.json",
        },
      },
    },
  },
}
