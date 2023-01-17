--=====================================================================
--
-- bufferline.lua -
--
-- Created by liubang on 2022/12/30 23:32
-- Last Modified: 2022/12/30 23:32
--
--=====================================================================
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = { -- {{{
      view = "multiwindow",
      mode = "buffers",
      numbers = "ordinal",
      close_command = "Bdelete",
      right_mouse_command = "Bdelete",
      middle_mouse_command = nil,
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 15,
      max_prefix_length = 14,
      tab_size = 15,
      diagnostics = false,
      diagnostics_update_in_insert = false,
      color_icons = true,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_buffer_default_icon = true,
      show_close_icon = false,
      show_tab_indicators = false,
      persist_buffer_sort = true,
      separator_style = "thin",
      enforce_regular_tabs = true,
      always_show_bufferline = false,
      sort_by = "insert_at_end",
    }, -- }}}
  },
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
}

-- vim: fdm=marker fdl=0
