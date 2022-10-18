--=====================================================================
--
-- smart-split.lua -
--
-- Created by liubang on 2022/09/03 17:37
-- Last Modified: 2022/10/18 23:28
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
