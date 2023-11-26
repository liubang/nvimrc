--=====================================================================
--
-- bufferline-nvim.lua -
--
-- Created by liubang on 2023/11/26 16:02
-- Last Modified: 2023/11/26 16:02
--
--=====================================================================

return {
  "akinsho/bufferline.nvim", -- {{{
  event = "VeryLazy",
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
      buffer_close_icon = "",
      modified_icon = "󰣕 ",
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
  },
  -- }}}
}
