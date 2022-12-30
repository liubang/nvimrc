--=====================================================================
--
-- mini.lua -
--
-- Created by liubang on 2022/12/30 22:24
-- Last Modified: 2022/12/30 22:24
--
--=====================================================================

local M = { "echasnovski/mini.nvim", event = "VeryLazy" }

function M.config()
  require("mini.surround").setup {
    n_lines = 40,
    highlight_duration = 1000,

    mappings = {
      add = "sa",
      delete = "sd",
      replace = "sc",
    },
  }

  require("mini.trailspace").setup {}

  require("mini.cursorword").setup {}

  require("mini.align").setup {
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
  }
end

return M

-- vim: fdm=marker fdl=0
