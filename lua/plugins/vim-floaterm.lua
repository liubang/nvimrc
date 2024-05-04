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
  "voldikss/vim-floaterm", -- {{{
  config = function()
    vim.g.floaterm_wintype = "float"
    vim.g.floaterm_position = "bottom"
    vim.g.floaterm_autoinsert = true
    vim.g.floaterm_width = vim.o.columns
    vim.g.floaterm_height = 0.7
    vim.g.floaterm_title = "─────  Floaterm [$1|$2] "
  end,
  cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
  keys = {
    { "<C-t>", "<CMD>FloatermToggle<CR>", desc = "Toggle floaterm" },
    {
      "<C-n>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNew<CR>", true, true, true),
      mode = { "t" },
      desc = "Create a new floaterm window",
    },
    {
      "<C-k>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermPrev<CR>", true, true, true),
      mode = { "t" },
      desc = "Goto previous floaterm window",
    },
    {
      "<C-j>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNext<CR>", true, true, true),
      mode = { "t" },
      desc = "Goto next floaterm window",
    },
    {
      "<C-t>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermToggle<CR>", true, true, true),
      mode = { "t" },
      desc = "Toggle floaterm",
    },
    {
      "<C-d>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermKill<CR>", true, true, true),
      mode = { "t" },
      desc = "Kill floaterm",
    },
  },
  -- }}}
}
