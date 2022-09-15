--=====================================================================
--
-- nvim-navic.lua -
--
-- Created by liubang on 2022/09/03 17:31
-- Last Modified: 2022/09/03 17:31
--
--=====================================================================
local navic = require 'nvim-navic'

-- stylua: ignore start
vim.g.navic_silence = true
local icons = { --{{{
  array         = " ",
  boolean       = "◩ ",
  calendar      = " ",
  class         = " ",
  constant      = " ",
  constructor   = " ",
  container     = " ",
  enum          = "練",
  enumMember    = " ",
  event         = " ",
  field         = " ",
  file          = " ",
  func          = " ",
  interface     = "練",
  key           = " ",
  method        = " ",
  module        = " ",
  namespace     = " ",
  null          = "ﳠ ",
  number        = " ",
  object        = " ",
  operator      = " ",
  package       = " ",
  property      = " ",
  string        = " ",
  struct        = " ",
  table         = " ",
  tag           = " ",
  typeParameter = " ",
  variable      = " ",
  watch         = " ",
} --}}}

navic.setup({ --{{{
  icons = {
    Array         = icons.array,
    Boolean       = icons.boolean,
    Class         = icons.class,
    Constant      = icons.constant,
    Constructor   = icons.constructor,
    Enum          = icons.enum,
    EnumMember    = icons.enumMember,
    Event         = icons.event,
    Field         = icons.field,
    File          = icons.file,
    Function      = icons.func,
    Interface     = icons.interface,
    Key           = icons.key,
    Method        = icons.method,
    Module        = icons.module,
    Namespace     = icons.namespace,
    Null          = icons.null,
    Number        = icons.number,
    Object        = icons.object,
    Operator      = icons.operator,
    Package       = icons.package,
    Property      = icons.property,
    String        = icons.string,
    Struct        = icons.struct,
    TypeParameter = icons.typeParameter,
    Variable      = icons.variable,
  },
  separator = ' > ',
  depth_limit = 3,
  highlight = true,
  depth_limit_indicator = "..",
}) --}}}
-- stylua: ignore end
