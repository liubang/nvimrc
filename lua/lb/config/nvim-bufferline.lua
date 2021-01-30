-- =====================================================================
--
-- nvim-bufferline.lua - 
--
-- Created by liubang on 2020/12/22 11:16
-- Last Modified: 2020/12/22 11:16
--
-- =====================================================================
local bufferline = require('bufferline')

local colors = {
  bg = '#3c3836',
  line_bg = '#665c54',
  fg = '#8FBCBB',
  fg_green = '#65a380',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67',
}

bufferline.setup {
  options = {
    numbers = 'ordinal', 
    mappings = false,
    close_icon = '\u{f18a}',
    modified_icon = '\u{fbba}',
    show_buffer_close_icons = false,
    always_show_bufferline = true,
  },
  highlights = {
    fill = {guifg = colors.fg, guibg = colors.bg},
    background = {guifg = colors.fg, guibg = colors.bg},
    tab = {guifg = colors.fg, guibg = colors.bg},
    tab_selected = {guifg = colors.fg, guibg = colors.line_bg},
    tab_close = {guifg = colors.fg, guibg = colors.line_bg},
    buffer_visible = {guifg = colors.fg, guibg = colors.bg},
    buffer_selected = {guifg = colors.fg, guibg = colors.line_bg, gui = 'bold'},
    modified = {guifg = colors.fg, guibg = colors.line_bg},
    modified_visible = {guifg = colors.fg, guibg = colors.bg},
    modified_selected = {guifg = colors.fg, guibg = colors.line_bg},
    duplicate_selected = {guifg = colors.fg, guibg = colors.line_bg, gui = ''},
    duplicate_visible = {guifg = colors.fg, guibg = colors.line_bg, gui = ''},
    duplicate = {guifg = colors.fg, guibg = colors.bg, gui = ''},
    separator_selected = {guifg = colors.blue, guibg = colors.line_bg},
    separator_visible = {guifg = colors.fg, guibg = colors.bg},
    separator = {guifg = colors.fg, guibg = colors.bg},
    indicator_selected = {guifg = colors.fg, guibg = colors.line_bg},
    pick_selected = {guifg = colors.fg, guibg = colors.line_bg, gui = 'bold'},
    pick_visible = {guifg = colors.fg, guibg = colors.line_bg, gui = 'bold'},
    pick = {guifg = colors.fg, guibg = colors.line_bg, gui = 'bold'},
  },
}
