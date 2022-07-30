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
    File = ' ',
    Module = ' ',
    Namespace = ' ',
    Package = ' ',
    Class = ' ',
    Method = ' ',
    Property = ' ',
    Field = ' ',
    Constructor = ' ',
    Enum = '練',
    Interface = '練',
    Function = ' ',
    Variable = ' ',
    Constant = ' ',
    String = ' ',
    Number = ' ',
    Boolean = '◩ ',
    Array = ' ',
    Object = ' ',
    Key = ' ',
    Null = 'ﳠ ',
    EnumMember = ' ',
    Struct = ' ',
    Event = ' ',
    Operator = ' ',
    TypeParameter = ' ',
  },
  highlight = false,
  separator = ' > ',
  depth_limit = 3,
  depth_limit_indicator = '..',
}
