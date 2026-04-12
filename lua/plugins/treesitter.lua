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
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "main",
  version = false, -- last release is way too old and doesn't work on Windows
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<C-v>", desc = "Increment Selection" },
    { "V", desc = "Decrement Selection", mode = "x" },
  },
  cmd = {
    "TSBufDisable",
    "TSBufEnable",
    "TSBufToggle",
    "TSDisable",
    "TSEnable",
    "TSToggle",
    "TSInstall",
    "TSInstallInfo",
    "TSInstallSync",
    "TSModuleInfo",
    "TSUninstall",
    "TSUpdate",
    "TSUpdateSync",
  },
  opts = (function()
    local large_cpp_filetypes = {
      c = true,
      cpp = true,
      objc = true,
      objcpp = true,
      cuda = true,
    }

    local function disable_highlight(_, buf)
      local filetype = vim.bo[buf].filetype
      if not large_cpp_filetypes[filetype] then
        return false
      end

      local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stat and stat.size and stat.size > 256 * 1024 then
        return true
      end

      return vim.api.nvim_buf_line_count(buf) > 5000
    end

    return {
      ensure_installed = {
        "go",
        "query",
        "rust",
        "lua",
        "java",
        "python",
        "proto",
        "gomod",
        "gosum",
        "gowork",
        "sql",
        "markdown",
        "markdown_inline",
        "vimdoc",
        "json",
        "tlaplus",
      },
      fold = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      matchup = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-v>",
          node_incremental = "v",
          node_decremental = "V",
          scope_incremental = false,
        },
      },
      highlight = {
        enable = true,
        disable = disable_highlight,
      },
    }
  end)(),
  config = function(_, opts)
    vim.api.nvim_set_option_value("foldmethod", "expr", {})
    vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})
    require("nvim-treesitter").setup(opts)
  end,
}
