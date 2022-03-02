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
    numbers = 'ordinal',
    close_icon = '\u{f18a}',
    modified_icon = '\u{fbba}',
    diagnostics = false,
    show_buffer_close_icons = false,
    always_show_bufferline = true,
  },
}
