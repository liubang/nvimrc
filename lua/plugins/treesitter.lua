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
  init = function()
    -- 大文件判断阈值（统一在顶层定义，opts 和 config 共用）
    vim.g.ts_max_filesize = 256 * 1024 -- 256 KB
    vim.g.ts_max_lines = 5000
  end,
  opts = (function()
    local function is_large_file(buf)
      local max_size = vim.g.ts_max_filesize or (256 * 1024)
      local max_lines = vim.g.ts_max_lines or 5000
      -- 优先用文件大小判断（attach 时文件已在磁盘，stat 更可靠）
      local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stat and stat.size and stat.size > max_size then
        return true
      end
      return vim.api.nvim_buf_line_count(buf) > max_lines
    end

    -- 所有文件类型都应用大文件保护
    local function disable_on_large(_, buf)
      return is_large_file(buf)
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
      -- fold 由 config 里的 autocmd 手动管理，避免与 foldexpr 双重控制
      fold = {
        enable = false,
      },
      indent = {
        enable = false,
      },
      matchup = {
        enable = true,
        -- 大文件禁用 matchup treesitter 集成，防止卡顿
        disable = disable_on_large,
        disable_virtual_text = true,
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
        disable = disable_on_large,
      },
    }
  end)(),
  config = function(_, opts)
    require("nvim-treesitter").setup(opts)

    local function is_large_file(buf)
      local max_size = vim.g.ts_max_filesize or (256 * 1024)
      local max_lines = vim.g.ts_max_lines or 5000
      local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stat and stat.size and stat.size > max_size then
        return true
      end
      return vim.api.nvim_buf_line_count(buf) > max_lines
    end

    -- 大文件降级为 indent fold，小文件用 treesitter foldexpr
    -- foldmethod/foldexpr 是 window-local 选项，必须用 win= 而非 buf=
    local function set_fold(buf)
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
          vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", { win = win })
        end
      end
    end

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      group = vim.api.nvim_create_augroup("TreesitterFold", { clear = true }),
      callback = function(ev)
        set_fold(ev.buf)
      end,
    })
  end,
}
