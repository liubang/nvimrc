--=====================================================================
--
-- which-key.lua -
--
-- Created by liubang on 2022/07/09 19:24
-- Last Modified: 2022/07/09 19:24
--
--=====================================================================

local wk = require 'which-key'
local mp = require 'lb.mappings'

wk.setup {
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true,
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },

  operators = {
    gb = 'Togggle block comment',
    gbc = 'Toggle block comment',
    gc = 'Toggle line comment',
    gcc = 'Toggle line comment',
  },
  popup_mappings = {
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },

  window = {
    border = 'single', -- none/single/double/shadow
  },
  layout = {
    height = { min = 4, max = 50 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },

  key_labels = {
    ['<CR>'] = 'RET',
    ['<Tab>'] = 'TAB',
    ['<S-Tab>'] = 'S-TAB',
    ['<leader>'] = 'SPC',
    ['<c-w>'] = '<C-W>',
  },

  ignore_missing = false,

  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },

  triggers = {},
  triggers_blacklist = {
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

for _, section in pairs(mp) do
  for mode, mode_mp in pairs(section) do
    for b, i in pairs(mode_mp) do
      wk.register({ [b] = i }, { mode = mode })
    end
  end
end
