--=====================================================================
--
-- yanky.lua -
--
-- Created by liubang on 2022/12/30 22:13
-- Last Modified: 2022/12/30 22:13
--
--=====================================================================
return {
  "gbprod/yanky.nvim",
  -- event = "BufReadPost",
  dependencies = {
    "kkharji/sqlite.lua",
  },
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
  },
  config = function()
    require("yanky").setup {
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 300,
      },
      preserve_cursor_position = {
        enabled = true,
      },
      ring = {
        storage = jit.os:find "Windows" and "shada" or "sqlite",
      },
    }
  end,
}

-- vim: fdm=marker fdl=0
