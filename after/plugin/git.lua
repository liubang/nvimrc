-- =====================================================================
--
-- git.lua -
--
-- Created by liubang on 2021/08/29 03:52
-- Last Modified: 2021/08/29 03:52
--
-- =====================================================================

require('gitsigns').setup {
  keymaps = {
    noremap = true,
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
  },
}
