-- =====================================================================
--
-- init.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:22
--
-- =====================================================================

pcall(require, "impatient")

require 'lb.globals'

vim.cmd [[runtime plugin/astronauta.vim]]

require 'lb.plugins'

require 'lb.lsp'
