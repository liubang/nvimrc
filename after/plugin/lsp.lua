--=====================================================================
--
-- lsp.lua -
--
-- Created by liubang on 2022/07/08 00:07
-- Last Modified: 2022/07/08 00:07
--
--=====================================================================

local saga = require 'lspsaga'
local navic = require 'nvim-navic'

-- lspsaga
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

-- nvim-navic
vim.g.navic_silence = true
navic.setup {
  icons = {
    Text = ' ',
    Method = ' ',
    Function = ' ',
    Constructor = ' ',
    Field = ' ',
    Variable = ' ',
    Class = 'ﴯ ',
    Interface = ' ',
    Module = ' ',
    Property = 'ﰠ ',
    Unit = ' ',
    Value = ' ',
    Enum = ' ',
    Keyword = ' ',
    Snippet = ' ',
    Color = ' ',
    File = ' ',
    Reference = ' ',
    Folder = ' ',
    EnumMember = ' ',
    Constant = ' ',
    Struct = 'פּ ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
  },
  highlight = false,
  separator = ' > ',
  depth_limit = 3,
  depth_limit_indicator = '..',
}
