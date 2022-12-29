--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/11/30 22:45
-- Last Modified: 2022/12/23 14:32
--
--=====================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "lb.options" -- global options
require "lb.lazy" -- plugins spec
require "lb.autocmd" -- events

vim.schedule(function()
  require "lb.commands"
  require "lb.mappings"
end)
