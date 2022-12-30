--=====================================================================
--
-- smart-splits.lua -
--
-- Created by liubang on 2022/12/30 22:14
-- Last Modified: 2022/12/30 22:14
--
--=====================================================================
return {
  "mrjones2014/smart-splits.nvim",
  event = { "BufReadPost" },
  config = function()
    require("smart-splits").setup {
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "NvimTree",
        "Outline",
        "qf",
        "prompt",
      },
      ignored_buftypes = { "NvimTree", "Outline" },
      resize_mode = {
        quit_key = "<ESC>",
        silent = true,
      },
    }
  end,
}

-- vim: fdm=marker fdl=0
