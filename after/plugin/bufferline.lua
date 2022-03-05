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
    numbers = 'both',
    close_icon = '\u{f18a}',
    modified_icon = '\u{fbba}',
    diagnostics = false,
    left_trunc_marker = '',
    right_trunc_marker = '',
    indicator_icon = '▎',
    buffer_close_icon = '',
    tab_size = 20,
    max_name_length = 20,
    max_prefix_length = 15,
    show_close_icon = true,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    always_show_bufferline = true,
    show_tab_indicators = true,
  },
}
