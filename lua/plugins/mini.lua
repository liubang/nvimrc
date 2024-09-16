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

return {
  {
    "echasnovski/mini.bufremove", -- {{{
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
    -- }}}
  },

  {
    "echasnovski/mini.align", -- {{{
    keys = {
      { "ga", mode = { "n", "x" } },
      { "gA", mode = { "n", "x" } },
    },
    opts = {
      mappings = {
        start = "ga",
        start_with_preview = "gA",
      },
      -- Default options controlling alignment process
      options = {
        split_pattern = "",
        justify_side = "left",
        merge_delimiter = "",
      },
      -- Default steps performing alignment (if `nil`, default is used)
      steps = {
        pre_split = {},
        split = nil,
        pre_justify = {},
        justify = nil,
        pre_merge = {},
        merge = nil,
      },
    },
    -- }}}
  },

  {
    "echasnovski/mini.surround", -- {{{
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      n_lines = 40,
      highlight_duration = 1000,
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
    -- }}}
  },
  {
    "echasnovski/mini.files",
    version = "*",
    opts = {
      content = {
        filter = nil,
        prefix = nil,
        sort = nil,
      },
      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      mappings = {
        close = "q",
        go_in = "",
        go_in_plus = "l",
        go_out = "",
        go_out_plus = "h",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
      -- General options
      options = {
        permanent_delete = true,
        use_as_default_explorer = false,
      },
      -- Customization of explorer windows
      windows = {
        max_number = math.huge,
        preview = false,
        width_focus = 50,
        width_nofocus = 15,
        width_preview = 25,
      },
    },
    keys = {
      {
        "<leader>mf",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
      {
        "<leader>mF",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open mini.files (cwd)",
      },
    },
  },
}
