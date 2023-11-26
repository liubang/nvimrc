--=====================================================================
--
-- yanky-nvim.lua -
--
-- Created by liubang on 2023/11/26 16:14
-- Last Modified: 2023/11/26 16:14
--
--=====================================================================

return {
  "gbprod/yanky.nvim", -- {{{
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
    { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
    { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
  },
  opts = {
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
    ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
  },
  -- }}}
}
