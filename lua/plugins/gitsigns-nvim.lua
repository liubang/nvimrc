--=====================================================================
--
-- gitsigns-nvim.lua -
--
-- Created by liubang on 2023/11/26 16:08
-- Last Modified: 2023/11/26 16:08
--
--=====================================================================

return {
  "lewis6991/gitsigns.nvim", -- {{{
  event = { "BufReadPre", "BufNewFile" },
  cmd = "Gitsigns",
  opts = {
    signs = {
      add = { text = "▌", show_count = true },
      change = { text = "▌", show_count = true },
      delete = { text = "▐", show_count = true },
      topdelete = { text = "▛", show_count = true },
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
    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = { enable = false },
  },
  keys = {
    {
      "<Leader>hb",
      function()
        require("gitsigns").blame_line({ full = true })
      end,
      mode = { "n" },
      desc = "Show the line git blame in a floating window",
    },
    {
      "<Leader>hd",
      function()
        require("gitsigns").diffthis()
      end,
      mode = { "n" },
      desc = "Perform a `vimdiff` on the given file",
    },
    {
      "<Leader>hr",
      function()
        require("gitsigns").reset_hunk()
      end,
      mode = { "n" },
      desc = "Reset the lines of the hunk at the cursor position",
    },
    {
      "<Leader>hs",
      function()
        require("gitsigns").stage_hunk()
      end,
      mode = { "n" },
      desc = "Stage the hunk at the cursor position",
    },
  },
  -- }}}
}
