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
  "jbyuki/venn.nvim", -- {{{
  event = { "VeryLazy" },
  init = function()
    vim.api.nvim_create_user_command("DrawBoxToggle", function()
      local venn_enabled = vim.inspect(vim.b.venn_enabled)
      if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.opt_local.ve = "all"
        vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", { buffer = true })
        vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", { buffer = true })
        vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", { buffer = true })
        vim.keymap.set("n", "L", "<C-v>l:VBox<CR>", { buffer = true })
        -- Draw a single line box or arrow.
        vim.keymap.set("x", "f", ":VBox<CR>", { buffer = true })
        -- Draw a double line box or arrow.
        vim.keymap.set("x", "d", ":VBoxD<CR>", { buffer = true })
        -- Draw a heavy line box or arrow.
        vim.keymap.set("x", "F", ":VBoxH<CR>", { buffer = true })
        vim.keymap.set("x", "o", ":VBoxO<CR>", { buffer = true })
        return
      end
      vim.opt_local.ve = ""
      vim.cmd.mapclear("<buffer>")
      vim.b.venn_enabled = nil
    end, { nargs = 0 })
  end,
  config = function()
    local venn = require("venn")
    venn.set_line({ "s", "s", " ", " " }, "|")
    venn.set_line({ " ", "s", " ", "s" }, "+")
    venn.set_line({ "s", " ", " ", "s" }, "+")
    venn.set_line({ " ", "s", "s", " " }, "+")
    venn.set_line({ "s", " ", "s", " " }, "+")
    venn.set_line({ " ", "s", "s", "s" }, "+")
    venn.set_line({ "s", " ", "s", "s" }, "+")
    venn.set_line({ "s", "s", " ", "s" }, "+")
    venn.set_line({ "s", "s", "s", " " }, "+")
    venn.set_line({ "s", "s", "s", "s" }, "+")
    venn.set_line({ " ", " ", "s", "s" }, "-")
    venn.set_arrow("up", "^")
    venn.set_arrow("down", "v")
    venn.set_arrow("left", "<")
    venn.set_arrow("right", ">")
  end,
  keys = { { "<leader>dt", ":DrawBoxToggle<CR>", desc = "Toggle venn" } },
  -- }}}
}
