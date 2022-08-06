--=====================================================================
--
-- nvim-surround.lua -
--
-- Created by liubang on 2022/07/13 22:33
-- Last Modified: 2022/07/13 22:33
--
--=====================================================================

require('nvim-surround').setup {
  keymaps = { -- vim-surround style keymaps
    insert = false,
    insert_line = false,
    visual = 'S',
    delete = 'ds',
    change = 'cs',
  },
}
