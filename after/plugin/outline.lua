--=====================================================================
--
-- outline.lua -
--
-- Created by liubang on 2022/03/02 16:58
-- Last Modified: 2022/03/02 16:58
--
--=====================================================================
local opts = {
  highlight_hovered_item = false,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = false,
  width = 40,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = false,
  keymaps = {
    close = { '<Esc>', 'q' },
    goto_location = '<Cr>',
    focus_location = 'o',
    hover_symbol = '<C-space>',
    toggle_preview = 'K',
    rename_symbol = 'r',
    code_actions = 'a',
  },
  symbols = {
    File = { icon = '', hl = 'TSURI' },
    Module = { icon = '', hl = 'TSNamespace' },
    Namespace = { icon = '', hl = 'TSNamespace' },
    Package = { icon = '', hl = 'TSNamespace' },
    Class = { icon = '', hl = 'TSType' },
    Method = { icon = '', hl = 'TSMethod' },
    Property = { icon = '', hl = 'TSMethod' },
    Field = { icon = '', hl = 'TSField' },
    Constructor = { icon = '', hl = 'TSConstructor' },
    Enum = { icon = ' ', hl = 'TSType' },
    Interface = { icon = 'ﰮ', hl = 'TSType' },
    Function = { icon = '', hl = 'TSFunction' },
    Variable = { icon = '', hl = 'TSConstant' },
    Constant = { icon = '', hl = 'TSConstant' },
    String = { icon = '𝓐', hl = 'TSString' },
    Number = { icon = '#', hl = 'TSNumber' },
    Boolean = { icon = '⊨', hl = 'TSBoolean' },
    Array = { icon = '', hl = 'TSConstant' },
    Object = { icon = '⦿', hl = 'TSType' },
    Key = { icon = '🔐', hl = 'TSType' },
    Null = { icon = 'NULL', hl = 'TSType' },
    EnumMember = { icon = '', hl = 'TSField' },
    Struct = { icon = 'פּ', hl = 'TSType' },
    Event = { icon = '', hl = 'TSType' },
    Operator = { icon = '', hl = 'TSOperator' },
    TypeParameter = { icon = '', hl = 'TSParameter' },
  },
}

require('symbols-outline').setup(opts)
