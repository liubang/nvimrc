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
  opts = { -- {{{
    timeout = 500,
    stages = "fade",
    icons = {
      DEBUG = "",
      ERROR = "",
      INFO = "",
      TRACE = "✎",
      WARN = "",
    },
  }, -- }}}
  init = function()
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.notify = function(...)
      require("lazy").load { plugins = { "nvim-notify" } }
      return require "notify"(...)
    end
  end,
}

-- vim: fdm=marker fdl=0
