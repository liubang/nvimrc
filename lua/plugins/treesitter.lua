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

local util = require("lb.utils.util")

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
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
  opts = {
    ensure_installed = {
      "c",
      "cpp",
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
      disable = util.bigfile,
      enable = true,
    },
    indent = {
      disable = util.bigfile,
      enable = false,
    },
    matchup = {
      enable = true,
      disable = util.bigfile,
    },
    incremental_selection = {
      enable = true,
      disable = util.bigfile,
      keymaps = {
        init_selection = "<C-v>",
        node_incremental = "v",
        node_decremental = "V",
        scope_incremental = false,
      },
    },
    highlight = {
      enable = true,
      -- Disable in large C++/C buffers
      disable = util.bigfile,
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_option_value("foldmethod", "expr", {})
    vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})
    require("nvim-treesitter.configs").setup(opts)
  end,
}
