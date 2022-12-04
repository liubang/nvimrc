--=====================================================================
--
-- go.lua -
--
-- Created by liubang on 2022/03/28 14:06
-- Last Modified: 2022/10/23 02:28
--
--=====================================================================

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.opt_local.formatoptions:remove { "t" }
vim.bo.expandtab = false

vim.cmd.compiler "go"
vim.opt_local.conceallevel = 2
vim.opt_local.foldlevel = 3
