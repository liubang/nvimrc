-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

local M = {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "debugloop/telescope-undo.nvim" },
    { "skywind3000/asynctasks.vim" },
  },
  keys = {
    { "<Leader>ff", "<CMD>Telescope find_files<CR>", mode = { "n" }, desc = "List files" },
    { "<Leader>rf", "<CMD>Telescope oldfiles<CR>", mode = { "n" }, desc = "List recent files" },
    { "<Leader>ag", "<CMD>Telescope live_grep_args<CR>", mode = { "n" }, desc = "Grep in files" },
    {
      "<Leader>Ag",
      "<CMD>Telescope grep_string<CR>",
      mode = { "n" },
      desc = "Searches for the string under your cursor (root dir)",
    },
    {
      "<Leader>bb",
      "<CMD>Telescope buffers<CR>",
      mode = { "n" },
      desc = "Lists open buffers in current neovim instance",
    },
    { "<Leader>ts", "<CMD>Telescope tasks<CR>", mode = { "n" }, desc = "Lists AsyncTasks for current buffer" },
    { "<Leader>br", "<CMD>BazelRun<CR>", mode = { "n" }, desc = "Bazl run" },
    { "<Leader>bt", "<CMD>BazelTest<CR>", mode = { "n" }, desc = "Bazel test" },
    { "<Leader>bs", "<CMD>BazelBuild<CR>", mode = { "n" }, desc = "Bazel build" },
  },
}

function M.init()
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.select = function(...)
    require("lazy").load({ plugins = { "telescope.nvim" } })
    return vim.ui.select(...)
  end
end

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")

  telescope.setup({
    defaults = { --{{{
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = " ",
      entry_prefix = "  ",
      multi_icon = "󰄴 ",
      set_env = { ["COLORTERM"] = "truecolor" },
      results_title = false,
      sorting_strategy = "ascending",
      selection_strategy = "reset",
      layout_strategy = "horizontal",
      use_less = true,
      border = {},
      preview = false,
      path_display = { "truncate" },
      winblend = 0,
      layout_config = {
        prompt_position = "top",
        horizontal = {
          prompt_position = "top",
          mirror = false,
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      file_ignore_patterns = { "node_modules" },
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
      live_grep_args = {
        preview = true,
        mappings = { -- extend mappings
          i = {
            ["<C-g>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
            ["<C-t>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -t " }),
          },
        },
      },
      fzf = {
        fuzzy = false,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    }, --}}}
  })

  telescope.load_extension("live_grep_args")
  telescope.load_extension("ui-select")
  telescope.load_extension("fzf")
  telescope.load_extension("bazel")
  telescope.load_extension("tasks")
  telescope.load_extension("undo")

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
end

return M

-- vim: fdm=marker fdl=0
