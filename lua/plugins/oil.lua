-- Copyright (c) 2025 The Authors. All rights reserved.
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
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    CustomOilBar = function()
      local path = vim.fn.expand("%")
      path = path:gsub("oil://", "")
      return "  " .. vim.fn.fnamemodify(path, ":.")
    end
    require("oil").setup({
      columns = { "icon" },
      keymaps = {
        ["?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = { "actions.select", mode = "n" },
        ["l"] = { "actions.select", mode = "n" },
        ["h"] = { "actions.parent", mode = "n" },
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-p>"] = { "actions.preview", mode = "n" },
        ["<C-r>"] = { "actions.refresh", mode = "n" },
        ["q"] = { "actions.close", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
      },
      win_options = {
        winbar = "%{v:lua.CustomOilBar()}",
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        colorcolumn = "",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "nvic",
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
          return vim.tbl_contains(folder_skip, name)
        end,
      },
      float = { max_width = 0.6, max_height = 0.6, border = "single" },
      confirmation = { border = "single" },
      progress = { border = "single" },
      ssh = { border = "single" },
      keymaps_help = { border = "single" },
    })
  end,
  keys = {
    { "-", "<CMD>Oil<CR>", mode = { "n" }, desc = "Open parent directory" },
    { "<Leader>-", "<CMD>Oil --float<CR>", mode = { "n" }, desc = "Open parent directory" },
  },
}
