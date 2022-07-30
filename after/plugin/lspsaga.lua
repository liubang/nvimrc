--=====================================================================
--
-- lspsaga.lua -
--
-- Created by liubang on 2022/07/31 01:03
-- Last Modified: 2022/07/31 01:03
--
--=====================================================================

local saga = require 'lspsaga'

saga.init_lsp_saga {
  border_style = 'single',
  saga_winblend = 0,
  move_in_saga = { prev = '<C-p>', next = '<C-n>' },
  show_diagnostic_source = true,
  code_action_icon = '  ',
  code_action_num_shortcut = true,
  code_action_keys = {
    quit = '<ESC>',
    exec = '<CR>',
  },
  code_action_lightbulb = {
    enable = false,
  },
  rename_action_quit = '<ESC>',
}
