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
  version = "v3.*",
  event = "BufAdd",
  config = function()
    require("bufferline").setup {
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
    }
  end,
}

-- vim: fdm=marker fdl=0
