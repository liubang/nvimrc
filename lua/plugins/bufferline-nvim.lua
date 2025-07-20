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
  "akinsho/bufferline.nvim", -- {{{
  -- event = "VeryLazy",
  event = { "BufReadPre", "BufAdd", "BufNewFile" },
  opts = {
    options = { -- {{{
      -- themable = true,
      numbers = "ordinal",
      indicator = { style = "underline" },
      close_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      middle_mouse_command = nil,
      buffer_close_icon = "󰅚",
      modified_icon = "󰣕",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      diagnostics = false,
      diagnostics_update_in_insert = false,
      sort_by = "insert_at_end",
    }, -- }}}
  },
  config = function(_, opts)
    local bufferline = require("bufferline")
    opts.options.style_preset = {
      bufferline.style_preset.no_italic,
      bufferline.style_preset.no_bold,
    }
    -- opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    bufferline.setup(opts)
  end,
  keys = {
    { "<Leader>1", "<CMD>BufferLineGoToBuffer 1<CR>", mode = { "n" }, desc = "Goto the 1th visible buffer" },
    { "<Leader>2", "<CMD>BufferLineGoToBuffer 2<CR>", mode = { "n" }, desc = "Goto the 2th visible buffer" },
    { "<Leader>3", "<CMD>BufferLineGoToBuffer 3<CR>", mode = { "n" }, desc = "Goto the 3th visible buffer" },
    { "<Leader>4", "<CMD>BufferLineGoToBuffer 4<CR>", mode = { "n" }, desc = "Goto the 4th visible buffer" },
    { "<Leader>5", "<CMD>BufferLineGoToBuffer 5<CR>", mode = { "n" }, desc = "Goto the 5th visible buffer" },
    { "<Leader>6", "<CMD>BufferLineGoToBuffer 6<CR>", mode = { "n" }, desc = "Goto the 6th visible buffer" },
    { "<Leader>7", "<CMD>BufferLineGoToBuffer 7<CR>", mode = { "n" }, desc = "Goto the 7th visible buffer" },
    { "<Leader>8", "<CMD>BufferLineGoToBuffer 8<CR>", mode = { "n" }, desc = "Goto the 8th visible buffer" },
    { "<Leader>9", "<CMD>BufferLineGoToBuffer 9<CR>", mode = { "n" }, desc = "Goto the 9th visible buffer" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", mode = { "n" }, desc = "Delete other buffers" },
  },
  -- }}}
}
