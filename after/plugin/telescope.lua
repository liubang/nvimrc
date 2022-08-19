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

local dropdown_borderchars = {
  prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
  results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
  preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
}

local dropdown_layout_config = {
  width = 0.55,
  height = 25,
}

telescope.setup {
  defaults = {
    prompt_prefix = '   ',
    prompt_title = false,
    results_title = false,
    preview_title = false,
    multi_icon = '',
    layout_strategy = 'flex',
    scroll_strategy = 'cycle',
    selection_strategy = 'reset',
    winblend = 0,
    dynamic_preview_title = true,
    color_devicons = true,
    layout_config = {
      vertical = {
        mirror = true,
      },
      center = {
        mirror = true,
      },
    },
    file_ignore_patterns = { 'build', 'tags', 'src/parser.c' },
    hl_result_eol = false,
    preview = false,
    cache = false,
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
      n = {
        ['<esc>'] = actions.close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
      },
    },
  },
  pickers = {
    buffers = {
      sort_mru = true,
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      mappings = {
        i = { ['<c-d>'] = actions.delete_buffer },
      },
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    frecency = {
      previewer = false,
      prompt_title = '',
      results_title = '',
    },
    projects = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    find_files = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    grep_string = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    live_grep = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    git_files = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    reloader = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    lsp_references = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    diagnostics = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    man_pages = { sections = { '2', '3' } },
    lsp_document_symbols = { path_display = { 'hidden' } },
    lsp_workspace_symbols = { path_display = { 'shorten' } },
    lsp_code_actions = {
      theme = 'dropdown',
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    current_buffer_fuzzy_find = {
      theme = 'dropdown',
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
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
      themes.get_dropdown {
        prompt_position = 'top',
        previewer = false,
        prompt_title = false,
        results_title = false,
        borderchars = dropdown_borderchars,
        layout_config = dropdown_layout_config,
      },
    },
    tasks = {
      themes.get_dropdown {
        prompt_position = 'top',
        previewer = false,
        prompt_title = false,
        results_title = false,
        borderchars = dropdown_borderchars,
        layout_config = dropdown_layout_config,
      },
    },
    ['ui-select'] = {
      themes.get_dropdown {
        prompt_position = 'top',
        previewer = false,
        prompt_title = false,
        results_title = false,
        borderchars = dropdown_borderchars,
        layout_config = dropdown_layout_config,
      },
    },
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'bazel'
telescope.load_extension 'tasks'
telescope.load_extension 'project'
telescope.load_extension 'ui-select'
