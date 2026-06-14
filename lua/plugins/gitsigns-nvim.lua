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
  "lewis6991/gitsigns.nvim", -- {{{
  event = { "BufReadPre" },
  cmd = "Gitsigns",
  opts = {
    -- stylua: ignore
    signs = {
      add          = { text = "▌", show_count = true },
      change       = { text = "▌", show_count = true },
      delete       = { text = "▐", show_count = true },
      topdelete    = { text = "▛", show_count = true },
      changedelete = { text = "▚", show_count = true },
    },
    update_debounce = 200,
    sign_priority = 10,
    numhl = false,
    signcolumn = true,
    max_file_length = 40000,
    watch_gitdir = { follow_files = true },
    count_chars = {
      [1] = "",
      [2] = "₂",
      [3] = "₃",
      [4] = "₄",
      [5] = "₅",
      [6] = "₆",
      [7] = "₇",
      [8] = "₈",
      [9] = "₉",
      ["+"] = "₊",
    },
    diff_opts = { -- {{{
      internal = true,
      algorithm = "patience",
      indent_heuristic = true,
      linematch = 60,
    }, -- }}}
    current_line_blame = false,
  },
  -- stylua: ignore
  keys = {
    { "]h", function() require("gitsigns").nav_hunk("next") end, desc = "Next hunk" },
    { "[h", function() require("gitsigns").nav_hunk("prev") end, desc = "Prev hunk" },
    { "<Leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage the hunk at the cursor position" },
    { "<Leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset the lines of the hunk at the cursor position" },
  },
  -- }}}
}
