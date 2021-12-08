--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/11/30 22:45
-- Last Modified: 2021/11/30 22:45
--
--=====================================================================

vim.cmd [[runtime plugin/astronauta.vim]]

-- use space as leader key
vim.g.mapleader = ' '

require 'lb.options'
require 'lb.globals'
require 'lb.plugin'
require 'lb.lsp'
require 'lb.commands'
require 'lb.events'
require 'lb.mappings'
