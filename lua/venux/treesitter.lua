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

-- 大文件降级：禁用 treesitter highlight，fold 回退为 indent
local function setup_large_file_protection()
  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("TreesitterLargeFile", { clear = true }),
    callback = function(ev)
      local buf = ev.buf
      if is_large_file(buf) then
        vim.treesitter.stop(buf)
        local wins = vim.fn.win_findbuf(buf)
        for _, win in ipairs(wins) do
          vim.api.nvim_set_option_value("foldmethod", "indent", { win = win })
          vim.api.nvim_set_option_value("foldexpr", "", { win = win })
        end
      end
    end,
  })
end

-- Fold 设置：小文件使用 treesitter foldexpr，大文件用 indent
local function setup_fold()
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("TreesitterFold", { clear = true }),
    callback = function(ev)
      local buf = ev.buf
      -- snacks.bigfile 已接管，跳过
      if vim.bo[buf].filetype == "bigfile" then
        return
      end
      local wins = vim.fn.win_findbuf(buf)
      if #wins == 0 then
        return
      end
      if is_large_file(buf) then
        for _, win in ipairs(wins) do
          vim.api.nvim_set_option_value("foldmethod", "indent", { win = win })
          vim.api.nvim_set_option_value("foldexpr", "", { win = win })
        end
      else
        for _, win in ipairs(wins) do
          vim.api.nvim_set_option_value("foldmethod", "expr", { win = win })
          vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { win = win })
        end
      end
    end,
  })
end

-- 基于 treesitter 节点的增量选择
local function setup_incremental_selection()
  local ns_node = nil -- 当前选中的节点

  --- 将节点范围设置为 visual 选区
  ---@param node TSNode
  local function select_node(node)
    local sr, sc, er, ec = node:range()
    -- range() 返回 0-indexed, end 是 exclusive
    -- 转换为 1-indexed 行号，end col 转为 inclusive
    if ec == 0 then
      -- 节点结束在行首，实际末尾在上一行的行尾
      er = er - 1
      ec = #vim.api.nvim_buf_get_lines(0, er, er + 1, true)[1]
    else
      ec = ec - 1
    end
    vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
    vim.fn.setpos("'>", { 0, er + 1, ec + 1, 0 })
    vim.cmd("normal! gv")
  end

  local function start_or_increment()
    local buf = vim.api.nvim_get_current_buf()
    if ns_node == nil then
      -- 初始选择：获取光标下的最小节点
      ns_node = vim.treesitter.get_node({ bufnr = buf })
      if not ns_node then
        return
      end
    else
      -- 扩展到父节点
      local parent = ns_node:parent()
      if parent then
        ns_node = parent
      end
    end
    select_node(ns_node)
  end

  local function decrement()
    if ns_node == nil then
      return
    end
    -- 尝试获取第一个命名子节点作为缩小选择
    local child = ns_node:named_child(0)
    if child then
      ns_node = child
    end
    select_node(ns_node)
  end

  -- 退出 visual mode 时重置节点状态
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = vim.api.nvim_create_augroup("TreesitterIncrementalSelection", { clear = true }),
    pattern = "[vV\x16]*:n",
    callback = function()
      ns_node = nil
    end,
  })

  vim.keymap.set("n", "<C-v>", start_or_increment, { desc = "Treesitter Increment Selection" })
  vim.keymap.set("x", "v", start_or_increment, { desc = "Treesitter Increment Selection" })
  vim.keymap.set("x", "V", decrement, { desc = "Treesitter Decrement Selection" })
end

--- 初始化内置 treesitter 相关配置
function M.setup()
  setup_large_file_protection()
  setup_fold()
  setup_incremental_selection()
end

return M
