--=====================================================================
--
-- nvim-notify.lua -
--
-- Created by liubang on 2022/09/03 17:01
-- Last Modified: 2022/12/04 03:39
--
--=====================================================================

local notify = require "notify"
notify.setup { -- {{{
  timeout = 500,
  stages = "fade",
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = "",
  },
} -- }}}
vim.notify = notify

-- vim: fdm=marker fdl=0
