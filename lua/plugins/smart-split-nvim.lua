--=====================================================================
--
-- smart-split-nvim.lua -
--
-- Created by liubang on 2023/11/26 16:11
-- Last Modified: 2023/11/26 16:11
--
--=====================================================================

return {
  "mrjones2014/smart-splits.nvim", -- {{{
  opts = {
    ignored_filetypes = {
      "nofile",
      "quickfix",
      "NvimTree",
      "Outline",
      "qf",
      "prompt",
    },
    ignored_buftypes = { "NvimTree", "Outline" },
    resize_mode = { quit_key = "<ESC>", silent = true },
  },
  keys = {
    {
      "<C-S-Up>",
      function()
        require("smart-splits").resize_up()
      end,
      mode = { "n" },
    },
    {
      "<C-S-Down>",
      function()
        require("smart-splits").resize_down()
      end,
      mode = { "n" },
    },
    {
      "<C-S-Left>",
      function()
        require("smart-splits").resize_left()
      end,
      mode = { "n" },
    },
    {
      "<C-S-Right>",
      function()
        require("smart-splits").resize_right()
      end,
      mode = { "n" },
    },
  },
  -- }}}
}
