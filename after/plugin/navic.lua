--=====================================================================
--
-- navic.lua -
--
-- Created by liubang on 2022/07/30 22:16
-- Last Modified: 2022/07/30 22:16
--
--=====================================================================

-- nvim-navic
vim.g.navic_silence = true

require('nvim-navic').setup {
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
