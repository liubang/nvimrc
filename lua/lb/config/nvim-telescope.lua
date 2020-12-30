-- =====================================================================
--
-- nvim-telescope.lua - 
--
-- Created by liubang on 2020/12/13 13:38
-- Last Modified: 2020/12/13 13:38
--
-- =====================================================================
local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    file_ignore_patterns = {'.git/*'},
    shorten_path = true,
    winblend = 0,
    mappings = {
      i = {
        ['<C-x>'] = false,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-c>'] = actions.close,
        ['<C-s>'] = actions.goto_file_selection_split,
        ['<C-v>'] = actions.goto_file_selection_vsplit
      },
      n = {['<esc>'] = actions.close}
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}

require('telescope').load_extension('fzy_native')
