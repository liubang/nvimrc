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
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec", "TermNew", "TermSelect" },
  keys = {
    { "<C-t>", "<CMD>ToggleTerm direction=float<CR>", desc = "Toggle float terminal" },
    { "<Leader>tt", "<CMD>TermSelect<CR>", desc = "Select terminal" },
    { "<Leader>tf", "<CMD>ToggleTerm direction=float<CR>", desc = "Toggle float terminal" },
    { "<Leader>th", "<CMD>ToggleTerm direction=horizontal<CR>", desc = "Toggle horizontal terminal" },
    {
      "<C-n>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N><CMD>TermNew direction=float<CR>", true, true, true),
      mode = { "t" },
      desc = "Create float terminal",
    },
    {
      "<C-t>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N><CMD>ToggleTerm direction=float<CR>", true, true, true),
      mode = { "t" },
      desc = "Toggle float terminal",
    },
    {
      "<C-j>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N><CMD>TermSelect<CR>", true, true, true),
      mode = { "t" },
      desc = "Select terminal",
    },
    {
      "<C-d>",
      vim.api.nvim_replace_termcodes("<C-\\><C-N><CMD>close<CR>", true, true, true),
      mode = { "t" },
      desc = "Close terminal window",
    },
  },
  opts = {
    open_mapping = nil,
    size = function(term)
      if term.direction == "horizontal" then
        return math.max(12, math.floor(vim.o.lines * 0.25))
      end
    end,
    direction = "float",
    start_in_insert = true,
    insert_mappings = true,
    persist_mode = true,
    close_on_exit = false,
    auto_scroll = true,
    shade_terminals = false,
    float_opts = {
      border = "single",
      width = function()
        return vim.o.columns
      end,
      height = function()
        return math.floor(vim.o.lines * 0.7)
      end,
      row = function()
        local height = math.floor(vim.o.lines * 0.7)
        return vim.o.lines - height - 3
      end,
      col = 0,
      title = " Floaterm ",
      title_pos = "center",
    },
  },
}
