-- =====================================================================
--
-- nvim-bufferline.lua - 
--
-- Created by liubang on 2020/12/22 11:16
-- Last Modified: 2020/12/22 11:16
--
-- =====================================================================
local bufferline = require('bufferline')

-- LuaFormatter off
bufferline.setup {
  options                   = {
    numbers                 = 'ordinal',
    mappings                = false,
    close_icon              = '\u{f18a}',
    modified_icon           = '\u{fbba}',
    show_buffer_close_icons = false,
    always_show_bufferline  = true,
  },
}
-- LuaFormatter on
