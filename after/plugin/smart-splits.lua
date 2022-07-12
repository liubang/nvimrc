--=====================================================================
--
-- smart-splits.lua -
--
-- Created by liubang on 2022/07/13 00:18
-- Last Modified: 2022/07/13 00:18
--
--=====================================================================

require('smart-splits').setup {
  ignored_filetypes = {
    'nofile',
    'quickfix',
    'NvimTree',
    'Outline',
    'qf',
    'prompt',
  },
  ignored_buftypes = { 'NvimTree', 'Outline' },
  resize_mode = {
    quit_key = '<ESC>',
    silent = true,
  },
}
