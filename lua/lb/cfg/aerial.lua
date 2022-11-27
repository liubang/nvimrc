--=====================================================================
--
-- aerial.lua -
--
-- Created by liubang on 2022/11/28 02:33
-- Last Modified: 2022/11/28 02:33
--
--=====================================================================

require('aerial').setup {
  backends = { 'lsp', 'treesitter', 'markdown' },
  layout = {
    default_direction = 'prefer_right',
    placement = 'edge',
  },
  attach_mode = 'global', -- 'window' | 'global'
  nerd_font = 'auto',
  show_guides = true,
}
