--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/11/30 22:45
-- Last Modified: 2022/10/18 00:38
--
--=====================================================================

require 'lb.plugin'
require 'lb.options'
require 'lb.autocmd'

vim.schedule(function()
  require 'lb.commands'
  require 'lb.mappings'
end)

-- stylua: ignore start
vim.defer_fn(function()vim.cmd.doautocmd 'User LoadTicker1' end, 100)
vim.defer_fn(function()vim.cmd.doautocmd 'User LoadTicker2' end, 200)
-- stylua: ignore end
