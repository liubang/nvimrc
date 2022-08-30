--=====================================================================
--
-- bufferline.lua -
--
-- Created by liubang on 2022/03/02 16:58
-- Last Modified: 2022/03/02 16:58
--
--=====================================================================

require('bufferline').setup {
  options = {
    mode = 'buffers',
    numbers = 'ordinal',
    -- close_command = 'bdelete! %d',
    -- right_mouse_command = 'bdelete! %d',
    -- left_mouse_command = 'buffer %d',
    middle_mouse_command = nil,
    indicator = {
      icon = '',
      style = 'none',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 15,
    max_prefix_length = 15,
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
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'insert_at_end',
  },
  highlights = {
    fill = {
      bg = '#3c3836',
      fg = '#ddc7a1',
    },
    background = {
      bg = '#5b534d',
      fg = '#ddc7a1',
    },
    tab_selected = {
      fg = '#32302f',
      bg = '#a89984',
    },
    buffer_visible = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    buffer_selected = {
      fg = '#32302f',
      bg = '#a89984',
      bold = true,
      italic = false,
    },
    numbers = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    numbers_visible = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    numbers_selected = {
      fg = '#32302f',
      bg = '#a89984',
      bold = true,
      italic = false,
    },
    duplicate_selected = {
      fg = '#32302f',
      bg = '#a89984',
      italic = false,
    },
    duplicate_visible = {
      fg = '#ddc7a1',
      bg = '#5b534d',
      italic = false,
    },
    duplicate = {
      fg = '#ddc7a1',
      bg = '#5b534d',
      italic = false,
    },
    close_button = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    close_button_visible = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    close_button_selected = {
      fg = '#32302f',
      bg = '#a89984',
    },
    separator_visible = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    separator = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    separator_selected = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    indicator_selected = {
      fg = '#32302f',
      bg = '#a89984',
    },
    modified = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    modified_visible = {
      fg = '#ddc7a1',
      bg = '#5b534d',
    },
    modified_selected = {
      fg = '#32302f',
      bg = '#a89984',
    },
  },
}
