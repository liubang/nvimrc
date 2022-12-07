-- =====================================================================
--
-- nvim-telescope.lua -
--
-- Created by liubang on 2020/12/13 13:38
-- Last Modified: 2022/12/05 00:56
--
-- =====================================================================

vim.cmd.packadd "telescope-fzf-native.nvim"
vim.cmd.packadd "telescope-ui-select.nvim"

local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
  defaults = { --{{{
    prompt_prefix = "   ",
    selection_caret = " ",
    entry_prefix = "  ",
    multi_icon = "",
    set_env = { ["COLORTERM"] = "truecolor" },
    results_title = false,
    sorting_strategy = "ascending",
    selection_strategy = "reset",
    layout_strategy = "horizontal",
    use_less = true,
    border = {},
    path_display = { truncate = 3 },
    layout_config = {
      prompt_position = "top",
      width = function(_, max_columns, _)
        return math.min(max_columns, 120)
      end,
      height = function(_, _, max_lines)
        return math.min(max_lines, 28)
      end,
      horizontal = {
        prompt_position = "top",
        mirror = false,
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
    },
    cache = false,
    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-u>"] = false,
        ["<C-d>"] = false,
        ["<Esc>"] = actions.close,
        ["<C-c>"] = actions.close,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-/>"] = "which_key",
      },
      n = {
        ["<Esc>"] = actions.close,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["?"] = actions.which_key,
      },
    },
  }, --}}}
  pickers = { --{{{
    buffers = {
      sort_mru = true,
      mappings = {
        i = { ["<c-d>"] = actions.delete_buffer },
      },
    },
    live_grep = { preview = true },
    grep_string = { preview = true },
    man_pages = { sections = { "2", "3" } },
    lsp_document_symbols = { path_display = { "hidden" } },
    lsp_workspace_symbols = { path_display = { "shorten" } },
  }, --}}}
  extensions = { --{{{
    fzf = {
      fuzzy = false,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  }, --}}}
}

telescope.load_extension "fzf"
telescope.load_extension "ui-select"
telescope.load_extension "bazel"
telescope.load_extension "tasks"

local colors = { --{{{
  white = "#ebdbb2",
  darker_black = "#222222",
  black = "#282828", --  nvim bg
  black2 = "#3c3836",
  one_bg = "#323232",
  one_bg2 = "#3b3b3b",
  one_bg3 = "#434343",
  grey = "#505050",
  grey_fg = "#5a5a5a",
  grey_fg2 = "#646464",
  light_grey = "#6c6c6c",
  red = "#ea6962",
  baby_pink = "#ce8196",
  pink = "#ff75a0",
  line = "#373737", -- for lines like vertsplit
  green = "#89b482",
  vibrant_green = "#a9b665",
  nord_blue = "#6f8faf",
  blue = "#6d8dad",
  yellow = "#d8a657",
  sun = "#eab869",
  purple = "#d3869b",
  dark_purple = "#d3869b",
  teal = "#749689",
  orange = "#e78a4e",
  cyan = "#89b482",
  statusline_bg = "#2c2c2c",
  lightbg = "#393939",
  pmenu_bg = "#89b482",
  folder_bg = "#6d8dad",
} --}}}

-- colors {{{
local TelescopePrompt = { --{{{
  TelescopeBorder = {
    fg = colors.darker_black,
    bg = colors.darker_black,
  },

  TelescopePromptBorder = {
    fg = colors.black2,
    bg = colors.black2,
  },

  TelescopePromptNormal = {
    fg = colors.white,
    bg = colors.black2,
  },

  TelescopePromptPrefix = {
    fg = colors.red,
    bg = colors.black2,
  },

  TelescopeNormal = { bg = colors.darker_black },

  TelescopePreviewTitle = {
    fg = colors.black,
    bg = colors.green,
  },

  TelescopePromptTitle = {
    fg = colors.black,
    bg = colors.red,
  },

  TelescopeResultsTitle = {
    fg = colors.darker_black,
    bg = colors.darker_black,
  },

  TelescopeSelection = { bg = colors.black2, fg = colors.white },

  TelescopeResultsDiffAdd = {
    fg = colors.green,
  },

  TelescopeResultsDiffChange = {
    fg = colors.yellow,
  },

  TelescopeResultsDiffDelete = {
    fg = colors.red,
  },
} --}}}

for hl, col in pairs(TelescopePrompt) do
  vim.api.nvim_set_hl(0, hl, col)
end
-- }}}

-- vim: fdm=marker fdl=0
