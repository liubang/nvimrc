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
  "stevearc/aerial.nvim", -- {{{
  cmd = "AerialToggle",
  opts = {
    backends = { "lsp", "markdown", "man" },
    layout = {
      default_direction = "prefer_right",
      placement = "edge",
    },
    attach_mode = "window", -- 'window' | 'global'
    nerd_font = "auto",
    show_guides = true,
    guides = {
      mid_item = "├╴",
      last_item = "└╴",
      nested_top = "│ ",
      whitespace = "  ",
    },
    keymaps = {
      ["<CR>"] = false,
      ["o"] = "actions.jump",
      ["<C-j>"] = "actions.down_and_scroll",
      ["<C-k>"] = "actions.up_and_scroll",
      ["O"] = "actions.tree_toggle",
    },
  },
  keys = {
    { "<Leader>tl", "<CMD>AerialToggle<CR>", mode = { "n" }, desc = "Open or close the aerial window" },
  },
  -- }}}
}
