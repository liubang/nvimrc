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

-- Parser 管理：tree-sitter-manager.nvim（nvim-treesitter 停更后的轻量替代）
-- 提供 :TSManager 交互式 TUI 界面安装/删除/更新 parser
-- 需要系统安装：tree-sitter CLI、git、C 编译器
return {
  "romus204/tree-sitter-manager.nvim",
  cmd = { "TSManager" },
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason-lspconfig.nvim" },
  },
  keys = {
    { "<C-v>", desc = "Treesitter Increment Selection" },
    { "V", desc = "Treesitter Decrement Selection", mode = "x" },
  },
  config = function(_, opts)
    require("tree-sitter-manager").setup(opts)
    require("venux.treesitter").setup()
  end,
  opts = {
    ensure_installed = {
      "go",
      "rust",
      "lua",
      "python",
      "java",
      "json",
      "proto",
      "gomod",
      "gosum",
      "gowork",
      "sql",
      "regex",
      "tlaplus",
      "query",
      "markdown",
      "markdown_inline",
      "vimdoc",
    },
    auto_install = true,
    highlight = true,
  },
}
