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
  cmd = "DrawBoxToggle",
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

    local mappings = {
      { "n", "H", "<C-v>h:VBox<CR>" },
      { "n", "J", "<C-v>j:VBox<CR>" },
      { "n", "K", "<C-v>k:VBox<CR>" },
      { "n", "L", "<C-v>l:VBox<CR>" },
      -- Draw a single line box or arrow.
      { "x", "f", ":VBox<CR>" },
      -- Draw a double line box or arrow.
      { "x", "d", ":VBoxD<CR>" },
      -- Draw a heavy line box or arrow.
      { "x", "F", ":VBoxH<CR>" },
      { "x", "o", ":VBoxO<CR>" },
    }
    local states = {}

    vim.api.nvim_create_autocmd("BufWipeout", {
      group = vim.api.nvim_create_augroup("VenuxVenn", { clear = true }),
      callback = function(args)
        local state = states[args.buf]
        if state then
          for win, virtualedit in pairs(state.windows) do
            if vim.api.nvim_win_is_valid(win) then
              vim.api.nvim_win_call(win, function()
                vim.opt_local.virtualedit = virtualedit
              end)
            end
          end
        end
        states[args.buf] = nil
      end,
    })

    vim.api.nvim_create_user_command("DrawBoxToggle", function()
      local buf = vim.api.nvim_get_current_buf()
      if vim.b[buf].venn_enabled then
        local state = states[buf]
        if state then
          for _, win in ipairs(vim.fn.win_findbuf(buf)) do
            local virtualedit = state.windows[win]
            if virtualedit == nil then
              virtualedit = state.virtualedit
            end
            vim.api.nvim_win_call(win, function()
              vim.opt_local.virtualedit = virtualedit
            end)
          end
          for _, map in ipairs(mappings) do
            vim.keymap.del(map[1], map[2], { buffer = buf })
          end
          for _, saved in ipairs(state.maps) do
            vim.fn.mapset(saved.mode, false, saved.map)
          end
          states[buf] = nil
        end
        vim.b[buf].venn_enabled = nil
        return
      end

      local state = {
        virtualedit = vim.opt_local.virtualedit:get(),
        windows = {},
        maps = {},
      }
      for _, win in ipairs(vim.fn.win_findbuf(buf)) do
        state.windows[win] = vim.wo[win].virtualedit
      end
      for _, map in ipairs(mappings) do
        local existing = vim.fn.maparg(map[2], map[1], false, true)
        if existing.buffer == 1 then
          table.insert(state.maps, { mode = map[1], map = existing })
        end
      end
      states[buf] = state
      vim.b[buf].venn_enabled = true
      vim.opt_local.virtualedit = "all"
      for _, map in ipairs(mappings) do
        vim.keymap.set(map[1], map[2], map[3], { buffer = buf })
      end
    end, { nargs = 0, desc = "Toggle draw box" })
  end,
  keys = { { "<leader>vv", ":DrawBoxToggle<CR>", desc = "Toggle draw box" } },
  -- }}}
}
