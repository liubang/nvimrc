-- =====================================================================
--
-- nvim-bufferline.lua - 
--
-- Created by liubang on 2020/12/22 11:16
-- Last Modified: 2020/12/22 11:16
--
-- =====================================================================
local bufferline = require('bufferline')

bufferline.setup {
  options = {
    numbers                 = 'ordinal',
    close_icon              = '\u{f18a}',
    modified_icon           = '\u{fbba}',
    diagnostics             = false,
    show_buffer_close_icons = false,
    always_show_bufferline  = true,
  },
}
