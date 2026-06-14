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
    { "<C-t>", "<CMD>ToggleTerm<CR>", desc = "Toggle terminal" },
  },
  opts = {
    size = math.floor(vim.o.lines * 0.55),
    direction = "horizontal",
    start_in_insert = true,
    insert_mappings = true,
    persist_mode = false,
    close_on_exit = true,
    auto_scroll = true,
    shade_terminals = false,
    on_open = function(term)
      if term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
        vim.keymap.set("t", "<C-t>", "<C-\\><C-N>:ToggleTerm<CR>", {
          buffer = term.bufnr,
          desc = "Toggle terminal",
        })
      end
      if term.window and vim.api.nvim_win_is_valid(term.window) then
        vim.api.nvim_set_option_value("number", false, { win = term.window })
        vim.api.nvim_set_option_value("relativenumber", false, { win = term.window })
        vim.api.nvim_set_option_value("signcolumn", "no", { win = term.window })
        vim.api.nvim_set_option_value("foldcolumn", "0", { win = term.window })
      end
    end,
  },
}
