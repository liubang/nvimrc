--=====================================================================
--
-- asynctasks.lua -
--
-- Created by liubang on 2022/11/12 01:18
-- Last Modified: 2022/12/01 23:55
--
--=====================================================================

local packer = require 'packer'
packer.loader 'asyncrun.vim'
packer.loader 'asyncrun.extra'

vim.g.asyncrun_open = 25
vim.g.asyncrun_bell = 1
vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', 'build.xml' }
vim.g.asynctasks_term_pos = 'floaterm'
vim.g.asynctasks_term_reuse = 1
