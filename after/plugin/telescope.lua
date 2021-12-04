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
local themes = require('telescope.themes')

telescope.setup {
  defaults = themes.get_dropdown({
    file_ignore_patterns = {'.git/*'},
    path_display = {'absolute'},
    winblend = 0,
    mappings = {
      i = {
        ['<C-x>'] = false,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-c>'] = actions.close,
        ['<C-s>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
      },
      n = {['<esc>'] = actions.close},
    },
  }),
  extensions = {

    fzy_native = {override_generic_sorter = true, override_file_sorter = true},

    fzf_writer = {use_highlighter = false, minimum_grep_characters = 6},

  },
}

telescope.load_extension('fzf')
telescope.load_extension('bazel')
telescope.load_extension('tasks')
telescope.load_extension('project')
telescope.load_extension('fzy_native')
