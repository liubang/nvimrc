-- =====================================================================
--
-- nvim-telescope.lua -
--
-- Created by liubang on 2020/12/13 13:38
-- Last Modified: 2020/12/13 13:38
--
-- =====================================================================
vim.cmd.packadd 'telescope-fzf-native.nvim'
vim.cmd.packadd 'telescope-ui-select.nvim'

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
    selection_caret = ' ',
    prompt_title = false,
    results_title = false,
    preview_title = false,
    multi_icon = '',
    layout_strategy = 'vertical',
    scroll_strategy = 'cycle',
    selection_strategy = 'reset',
    winblend = 0,
    dynamic_preview_title = true,
    color_devicons = true,
    layout_config = {
      vertical = {
        prompt_position = 'top',
        mirror = false,
      },
      center = {
        prompt_position = 'top',
        mirror = false,
      },
    },
    hl_result_eol = false,
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
      prompt_title = false,
      results_title = false,
      borderchars = dropdown_borderchars,
      layout_config = dropdown_layout_config,
    },
    live_grep = {
      theme = 'dropdown',
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
      -- previewer = true,
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
      fuzzy = false,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    ['ui-select'] = {
      themes.get_dropdown {
        previewer = false,
        prompt_title = false,
        results_title = false,
        borderchars = dropdown_borderchars,
        layout_config = dropdown_layout_config,
      },
    },
    tasks = {
      themes.get_dropdown {
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
telescope.load_extension 'ui-select'
