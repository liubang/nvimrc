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
-- Created: 2026/05/16 19:32

-- Neovim 0.12+ built-in treesitter configuration.
-- Handles large file protection, fold, and incremental selection.

local M = {}

-- 大文件判断阈值
local MAX_FILESIZE = 256 * 1024 -- 256 KB
local MAX_LINES = 5000

---@param buf integer
---@return boolean
local function is_large_file(buf)
  local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
  if ok and stat and stat.size and stat.size > MAX_FILESIZE then
    return true
  end
  return vim.api.nvim_buf_line_count(buf) > MAX_LINES
end

-- Fold 设置：小文件使用 treesitter foldexpr，大文件用 indent
---@param buf integer
local function set_fold(buf)
  -- snacks.bigfile 已接管，跳过
  if vim.bo[buf].filetype == "bigfile" then
    return
  end

  local wins = vim.fn.win_findbuf(buf)
  if #wins == 0 then
    return
  end

  local large_file = is_large_file(buf)
  local foldmethod = large_file and "indent" or "expr"
  local foldexpr = large_file and "" or "v:lua.vim.treesitter.foldexpr()"
  for _, win in ipairs(wins) do
    vim.api.nvim_set_option_value("foldmethod", foldmethod, { win = win })
    vim.api.nvim_set_option_value("foldexpr", foldexpr, { win = win })
  end
end

-- 大文件降级：禁用 treesitter highlight，fold 回退为 indent
local function setup_large_file_protection()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreesitterLargeFile", { clear = true }),
    callback = function(ev)
      local buf = ev.buf
      if is_large_file(buf) then
        vim.treesitter.stop(buf)
        set_fold(buf)
      end
    end,
  })
end

local function setup_fold()
  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("TreesitterFold", { clear = true }),
    callback = function(ev)
      set_fold(ev.buf)
    end,
  })
end

-- 使用 Neovim 0.12 内置实现维护基于 treesitter 节点的增量选择
local function setup_incremental_selection()
  local function select(target)
    return function()
      vim.treesitter.select(target, vim.v.count1)
    end
  end

  local select_parent = select("parent")
  vim.keymap.set("n", "<Leader>i", select_parent, { desc = "Treesitter Increment Selection" })
  vim.keymap.set("x", "<Leader>i", select_parent, { desc = "Treesitter Increment Selection" })
  vim.keymap.set("x", "<Leader>I", select("child"), { desc = "Treesitter Decrement Selection" })
end

--- 初始化内置 treesitter 相关配置
function M.setup()
  setup_large_file_protection()
  setup_fold()
  setup_incremental_selection()
end

return M
