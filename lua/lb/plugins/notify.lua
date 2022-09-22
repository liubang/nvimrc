--=====================================================================
--
-- nvim-notify.lua -
--
-- Created by liubang on 2022/09/03 17:01
-- Last Modified: 2022/09/03 17:01
--
--=====================================================================

local async_load_plugin = nil
async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function()
  local notify = require 'notify'
  notify.setup {
    timeout = 2000,
    icons = {
      ERROR = ' ',
      WARN = ' ',
      INFO = ' ',
      DEBUG = ' ',
      TRACE = ' ',
    },
  }
  vim.notify = notify
  async_load_plugin:close()
end))
async_load_plugin:send()
