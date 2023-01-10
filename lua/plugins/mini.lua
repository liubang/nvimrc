--=====================================================================
--
-- mini.lua -
--
-- Created by liubang on 2022/12/30 22:24
-- Last Modified: 2022/12/30 22:24
--
--=====================================================================

local M = {
  {
    "echasnovski/mini.surround",
    keys = { { "sa", mode = { "n", "x" } } },
    opts = {
      n_lines = 40,
      highlight_duration = 1000,
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
  },
  {
    "echasnovski/mini.align",
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
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
  },
  {
    "echasnovski/mini.cursorword",
    event = { "BufReadPost", "BufNewFile" },
    config = function(_, opts)
      require("mini.cursorword").setup(opts)
    end,
  },
}

return M

-- vim: fdm=marker fdl=0
