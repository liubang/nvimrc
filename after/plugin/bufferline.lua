--=====================================================================
--
-- bufferline.lua -
--
-- Created by liubang on 2022/03/02 16:58
-- Last Modified: 2022/03/02 16:58
--
--=====================================================================
local bufferline = require 'bufferline'

local options = {
  options = {
    numbers = 'both',
    buffer_close_icon = '',
    modified_icon = '',
    close_icon = '',
    show_close_icon = false,
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 14,
    max_prefix_length = 13,
    tab_size = 20,
    show_tab_indicators = true,
    enforce_regular_tabs = false,
    view = 'multiwindow',
    show_buffer_close_icons = true,
    separator_style = 'thin',
    always_show_bufferline = true,
    diagnostics = false,
    themable = true,
  },
}

bufferline.setup(options)
