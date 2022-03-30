-- =====================================================================
--
-- nvim-telescope.lua -
--
-- Created by liubang on 2020/12/13 13:38
-- Last Modified: 2020/12/13 13:38
--
-- =====================================================================

local actions = require 'telescope.actions'
local telescope = require 'telescope'
local themes = require 'telescope.themes'

telescope.setup {
  defaults = themes.get_dropdown {
    file_ignore_patterns = { '.git/*' },
    prompt_prefix = '  ',
    path_display = { 'absolute' },
    winblend = 0,
    mappings = {
      i = {
        ['<C-x>'] = false,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<C-c>'] = actions.close,
        ['<C-s>'] = actions.select_horizontal,
        ['<C-v>'] = actions.select_vertical,
        ['<C-/>'] = 'which_key',
      },
      n = { ['<esc>'] = actions.close },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
    },
    project = {
      hidden_files = true,
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {
        -- even more opts
      },
    },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'bazel'
telescope.load_extension 'tasks'
telescope.load_extension 'project'
telescope.load_extension 'ui-select'
