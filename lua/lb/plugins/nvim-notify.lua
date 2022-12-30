--=====================================================================
--
-- nvim-notify.lua -
--
-- Created by liubang on 2022/12/30 23:45
-- Last Modified: 2022/12/30 23:45
--
--=====================================================================
return {
  "rcarriga/nvim-notify",
  config = function()
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
  end,
  event = { "VeryLazy" },
}

-- vim: fdm=marker fdl=0
