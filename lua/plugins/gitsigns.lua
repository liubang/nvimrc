--=====================================================================
--
-- gitsigns.lua -
--
-- Created by liubang on 2022/12/30 22:21
-- Last Modified: 2022/12/30 22:21
--
--=====================================================================

-- stylua: ignore start
return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  cmd = "Gitsigns",
  config = function()
    local gitsigns = require "gitsigns"
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
        [1]   = "",
        [2]   = "₂",
        [3]   = "₃",
        [4]   = "₄",
        [5]   = "₅",
        [6]   = "₆",
        [7]   = "₇",
        [8]   = "₈",
        [9]   = "₉",
        ["+"] = "₊",
      },
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    }
  end,
}

-- stylua: ignore end

-- vim: fdm=marker fdl=0
