--=====================================================================
--
-- gitsigns.lua -
--
-- Created by liubang on 2022/12/30 22:21
-- Last Modified: 2022/12/30 22:21
--
--=====================================================================
return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  config = function()
    local gitsigns = require "gitsigns"
    -- stylua: ignore start
    gitsigns.setup {
      signs = {
        add          = { text = "▌", show_count = true },
        change       = { text = "▌", show_count = true },
        delete       = { text = "▐", show_count = true },
        topdelete    = { text = "▛", show_count = true },
        changedelete = { text = "▚", show_count = true },
      },
      sign_priority = 10,
      count_chars = {
        [1] = "",
        [2] = "₂",
        [3] = "₃",
        [4] = "₄",
        [5] = "₅",
        [6] = "₆",
        [7] = "₇",
        [8] = "₈",
        [9] = "₉",
        ["+"] = "₊",
      },

      diff_opts = {
        internal = true,
        algorithm = "patience",
        indent_heuristic = true,
        linematch = 60,
      },
    }
    -- stylua: ignore end
  end,
}

-- vim: fdm=marker fdl=0
