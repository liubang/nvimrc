-- =====================================================================
--
-- nvim-telescope.lua - 
--
-- Created by liubang on 2020/12/13 13:38
-- Last Modified: 2020/12/13 13:38
--
-- =====================================================================
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup {
  defaults = {
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
        ['<C-v>'] = actions.goto_file_selection_vsplit,
      },
      n = {['<esc>'] = actions.close},
    },
  },
  extensions = {
    fzy_native = {override_generic_sorter = false, override_file_sorter = true},
    fzf_writer = {minimum_grep_characters = 2, minimum_files_characters = 2, use_highlighter = true},
  },
}

telescope.load_extension('fzy_native')
