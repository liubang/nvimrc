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
  "mfussenegger/nvim-lint",
  lazy = false,
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      markdown = { "vale" },
      dockerfile = { "hadolint" },
      bash = { "shellcheck" },
    }
    local function get_cur_file_extension(bufnr)
      bufnr = bufnr or 0
      return "." .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":e")
    end
    lint.linters.vale.args = {
      "--no-exit",
      "--output",
      "JSON",
      "--config",
      vim.fn.stdpath("config") .. "/data/vale/.vale.ini",
      "--ext",
      get_cur_file_extension,
    }
    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = function()
        lint.try_lint()
      end,
    })

    local bufopts = { noremap = true, silent = true }
    vim.keymap.set("n", "<Leader>ee", function()
      vim.diagnostic.open_float(nil, { scope = "line" })
    end, bufopts)
    vim.keymap.set("n", "<Leader>es", "<cmd>Telescope diagnostics bufnr=0<CR>", bufopts)
  end,
}
