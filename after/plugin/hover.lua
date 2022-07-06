--=====================================================================
--
-- hover.lua -
--
-- Created by liubang on 2022/07/07 00:36
-- Last Modified: 2022/07/07 00:36
--
--=====================================================================
require('hover').setup {
  init = function()
    require 'hover.providers.lsp'
  end,

  preview_opts = {
    border = 'single',
  },

  title = true,
}
