--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/11/30 22:45
-- Last Modified: 2021/11/30 22:45
--
--=====================================================================

require 'lb.globals'
require 'lb.options'
require 'lb.plugin'
require 'lb.commands'
require 'lb.events'
require 'lb.mappings'

vim.defer_fn(function()
  vim.cmd.doautocmd 'User LoadTicker'
end, 200)
