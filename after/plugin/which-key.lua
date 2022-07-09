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
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '  ', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
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

  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

local c = 0
for _, section in pairs(mp) do
  for mode, mode_mp in pairs(section) do
    for b, i in pairs(mode_mp) do
      wk.register({ [b] = i }, { mode = mode })
      c = c + 1
    end
  end
end
