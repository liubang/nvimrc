--=====================================================================
--
-- tools.lua -
--
-- Created by liubang on 2022/07/21 23:49
-- Last Modified: 2022/07/21 23:49
--
--=====================================================================

-- floaterm
vim.g.floaterm_wintype = 'float'
vim.g.floaterm_position = 'bottom'
vim.g.floaterm_autoinsert = true
vim.g.floaterm_width = 0.999
vim.g.floaterm_height = 0.7
vim.g.floaterm_title = '─────  Floaterm [$1|$2] '

-- asyncrun/asynctasks
vim.g.asyncrun_open = 25
vim.g.asyncrun_bell = 1
vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', 'build.xml' }
vim.g.asynctasks_term_pos = 'floaterm'
vim.g.asynctasks_term_reuse = 1

-- nvim-surround
require('nvim-surround').setup {
  keymaps = { -- vim-surround style keymaps
    insert = false,
    insert_line = false,
    visual = 'S',
    delete = 'ds',
    change = 'cs',
  },
}

-- smart-splits
require('smart-splits').setup {
  ignored_filetypes = {
    'nofile',
    'quickfix',
    'NvimTree',
    'Outline',
    'qf',
    'prompt',
  },
  ignored_buftypes = { 'NvimTree', 'Outline' },
  resize_mode = {
    quit_key = '<ESC>',
    silent = true,
  },
}
