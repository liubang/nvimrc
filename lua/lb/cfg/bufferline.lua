--=====================================================================
--
-- bufferline.lua -
--
-- Created by liubang on 2022/03/02 16:58
-- Last Modified: 2022/10/18 23:27
--
--=====================================================================

require('bufferline').setup {
  options = {
    view = 'multiwindow',
    mode = 'buffers',
    numbers = 'ordinal',
    close_command = 'Bdelete',
    right_mouse_command = 'Bdelete',
    middle_mouse_command = nil,
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    -- max_name_length = 15,
    -- max_prefix_length = 15,
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
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = 'insert_at_end',
  },
}

vim.keymap.set('n', '<Leader>1', '<cmd>BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', '<Leader>2', '<cmd>BufferLineGoToBuffer 2<CR>')
vim.keymap.set('n', '<Leader>3', '<cmd>BufferLineGoToBuffer 3<CR>')
vim.keymap.set('n', '<Leader>4', '<cmd>BufferLineGoToBuffer 4<CR>')
vim.keymap.set('n', '<Leader>5', '<cmd>BufferLineGoToBuffer 5<CR>')
vim.keymap.set('n', '<Leader>6', '<cmd>BufferLineGoToBuffer 6<CR>')
vim.keymap.set('n', '<Leader>7', '<cmd>BufferLineGoToBuffer 7<CR>')
vim.keymap.set('n', '<Leader>8', '<cmd>BufferLineGoToBuffer 8<CR>')
vim.keymap.set('n', '<Leader>9', '<cmd>BufferLineGoToBuffer 9<CR>')
