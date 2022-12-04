--=====================================================================
--
-- mini-nvim.lua -
--
-- Created by liubang on 2022/10/16 15:44
-- Last Modified: 2022/11/26 17:14
--
--=====================================================================

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
