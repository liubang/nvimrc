--=====================================================================
--
-- comment.lua -
--
-- Created by liubang on 2023/11/26 15:37
-- Last Modified: 2023/11/26 15:37
--
--=====================================================================

return {
  "numToStr/Comment.nvim", -- {{{
  keys = {
    { "gc", mode = { "n", "x" }, desc = "Toggle line comment" },
    { "gb", mode = { "n", "x" }, desc = "Toggle block comment" },
    { "gcc", mode = "n", desc = "Toggle line comment" },
    { "gcb", mode = "n", desc = "Toggle block comment" },
  },
  opts = function()
    -- set rust comment string
    local ft = require("Comment.ft")
    ft.set("rust", "///%s")

    return {
      padding = true,
      mappings = {
        basic = true,
        extra = false,
      },
    }
  end,
  -- }}}
}
