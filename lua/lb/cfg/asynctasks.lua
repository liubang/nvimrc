--=====================================================================
--
-- asynctasks.lua -
--
-- Created by liubang on 2022/11/12 01:18
-- Last Modified: 2022/11/12 01:18
--
--=====================================================================

vim.cmd.packadd 'asyncrun.vim'
vim.cmd.packadd 'asyncrun.extra'
vim.g.asyncrun_open = 25
vim.g.asyncrun_bell = 1
vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', 'build.xml' }
vim.g.asynctasks_term_pos = 'floaterm'
vim.g.asynctasks_term_reuse = 1
