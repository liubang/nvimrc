--=====================================================================
--
-- asynctasks.lua -
--
-- Created by liubang on 2022/11/12 01:18
-- Last Modified: 2022/12/05 00:56
--
--=====================================================================

vim.cmd.packadd "asyncrun.vim"
vim.cmd.packadd "asyncrun.extra"
vim.cmd.packadd "vim-floaterm"

vim.g.asyncrun_bell = 1
vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "build.xml" }
vim.g.asynctasks_term_pos = "floaterm"
