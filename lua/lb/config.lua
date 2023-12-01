--=====================================================================
--
-- config.lua -
--
-- Created by liubang on 2023/10/28 23:19
-- Last Modified: 2023/10/28 23:19
--
--=====================================================================

return {
  lsp = {
    diagnostic = {
      -- stylua: ignore
      icons= {
        Error = " ",
        Warn  = " ",
        Info  = " ",
        Hint  = " ",
      },
    },
  },
  -- stylua: ignore
  kinds = {
		Function      = "󰘧 ",
    Array         = " ",
    Boolean       = " ",
    Class         = " ",
    Color         = " ",
    Constant      = "󰏿 ",
    Constructor   = " ",
    Enum          = "󰯷 ",
    EnumMember    = " ",
    Event         = "󱩠 ",
    Field         = "󰐣 ",
    File          = " ",
    Folder        = " ",
    Interface     = " ",
    Key           = " ",
    Keyword       = "󰰉 ",
    Method        = " ",
    Module        = " ",
    Namespace     = " ",
    Null          = "ﳠ ",
    Number        = "󱌨 ",
    Object        = " ",
    Operator      = "󱓉 ",
    Package       = "󰠰 ",
    Property      = "󰰘 ",
    Reference     = "󰌹 ",
    Snippet       = " ",
    String        = "󱌮 ",
    Struct        = " ",
    Text          = " ",
    TypeParameter = " ",
    Unit          = "󰰧 ",
    Value         = "󰰪 ",
    Variable      = "󰤷 ",
  },
}
