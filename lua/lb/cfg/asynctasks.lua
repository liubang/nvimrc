--=====================================================================
--
-- asynctasks.lua -
--
-- Created by liubang on 2022/11/12 01:18
-- Last Modified: 2022/12/06 00:39
--
--=====================================================================

vim.cmd.packadd "asyncrun.vim"
vim.cmd.packadd "asyncrun.extra"

-- because vim-floaterm has its own configuration file, it needs to use packer.loader to load
require("packer").loader "vim-floaterm"

vim.g.asyncrun_bell = 1
vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "build.xml" }
vim.g.asynctasks_term_pos = "floaterm"
