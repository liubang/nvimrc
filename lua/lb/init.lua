--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/11/30 22:45
-- Last Modified: 2022/10/19 13:06
--
--=====================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "lb.options" -- global options
require "lb.plugins" -- plugins spec
require "lb.autocmd" -- events

vim.schedule(function()
  require "lb.commands"
  require "lb.mappings"
end)

-- stylua: ignore start
vim.defer_fn(function()vim.cmd.doautocmd 'User LoadTicker1' end, 100)
vim.defer_fn(function()vim.cmd.doautocmd 'User LoadTicker2' end, 300)
vim.defer_fn(function()vim.cmd.doautocmd 'User LoadTicker3' end, 600)
vim.defer_fn(function()vim.cmd.doautocmd 'User LoadTicker4' end, 900)
-- stylua: ignore end
