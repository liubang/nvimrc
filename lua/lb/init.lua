--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/11/30 22:45
-- Last Modified: 2021/11/30 22:45
--
--=====================================================================

pcall(require, 'impatient')

vim.cmd [[runtime plugin/astronauta.vim]]

require 'lb.options'
require 'lb.globals'
require 'lb.plugins'
require 'lb.lsp'
require 'lb.commands'
require 'lb.events'
require 'lb.mappings'
