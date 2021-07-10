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
    path_display = {'absolute'},
    winblend = 0,
    -- theme start
    results_title = false,
    preview_title = 'Preview',
    sorting_strategy = 'ascending',
    layout_strategy = 'center',
    layout_config = {
      preview_cutoff = 1, -- Preview should always show (unless previewer = false)

      width = function(_, max_columns, _)
        return math.min(max_columns - 3, 80)
      end,

      height = function(_, _, max_lines)
        return math.min(max_lines - 4, 15)
      end,
    },
    border = true,
    borderchars = {
      {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
      prompt = {'─', '│', ' ', '│', '╭', '╮', '│', '│'},
      results = {'─', '│', '─', '│', '├', '┤', '╯', '╰'},
      preview = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    },
    -- theme end
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
  },
  extensions = {
    fzy_native = {override_generic_sorter = false, override_file_sorter = true},
    fzf_writer = {
      minimum_grep_characters = 2,
      minimum_files_characters = 2,
      use_highlighter = true,
    },
  },
}

