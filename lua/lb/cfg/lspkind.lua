--=====================================================================
--
-- lspkind.lua -
--
-- Created by liubang on 2022/12/01 23:09
-- Last Modified: 2022/12/01 23:09
--
--=====================================================================

require('lspkind').init {
  symbol_map = {
    NONE = '',
    Array = '',
    Boolean = '⊨',
    Class = '',
    Constructor = '',
    Key = '',
    Namespace = '',
    Null = 'NULL',
    Number = '#',
    Object = '⦿',
    Package = '',
    Property = '',
    Reference = '',
    Snippet = '',
    String = '𝓐',
    TypeParameter = '',
    Unit = '',
  },
}
