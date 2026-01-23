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

return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  -- stylua: ignore
  keys = {
    { "<leader>fm", function() require("conform").format() end, mode = { "n", "v" } },
  },
  opts = function()
    local opts = { formatters_by_ft = {} }
    for _, ft in ipairs({
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
    }) do
      opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
      table.insert(opts.formatters_by_ft[ft], "prettier")
    end
    opts.formatters_by_ft["lua"] = { "stylua" }
    opts.formatters_by_ft["go"] = { "gofumpt" }
    opts.formatters_by_ft["sh"] = { "shfmt" }
    opts.formatters_by_ft["sql"] = { "sleek" }
    opts.formatters_by_ft["python"] = { "ruff" }
    opts.formatters_by_ft["bzl"] = { "buildifier" }
    opts.formatters_by_ft["c"] = { "clang-format" }
    opts.formatters_by_ft["cpp"] = { "clang-format" }
    opts.formatters_by_ft["_"] = { "trim_whitespace" }
    opts.formatters = {
      injected = { options = { ignore_errors = true } },
      sleek = {
        command = "sleek",
        stdin = true,
        append_args = {
          "--indent-spaces",
          "4",
          "-U",
          "true",
        },
      },
    }
    opts.default_format_opts = {
      timeout_ms = 3000,
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
      lsp_format = "fallback", -- not recommended to change
    }
    return opts
  end,
}
