-- =====================================================================
--
-- comment.lua -
--
-- Created by liubang on 2021/08/31 22:41
-- Last Modified: 2022/12/22 19:16
--
-- =====================================================================

local comment = require "Comment"
local ft = require "Comment.ft"

comment.setup {
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

ft.set("rust", "///%s")
