--=====================================================================
--
-- comment.lua -
--
-- Created by liubang on 2022/12/30 22:11
-- Last Modified: 2022/12/30 22:11
--
--=====================================================================

return {
  "numToStr/Comment.nvim",
  keys = { { "gcc", mode = { "n", "x" } }, { "gcb", mode = { "n", "x" } } },
  opts = function()
    local ft = require "Comment.ft"
    ft.set("rust", "///%s")

    return {
      padding = true,
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

      ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
      ---@type table
      mappings = {
        ---operator-pending mapping
        ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = false,
      },
    }
  end,
}

-- vim: fdm=marker fdl=0
