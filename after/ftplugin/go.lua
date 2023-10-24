--=====================================================================
--
-- go.lua -
--
-- Created by liubang on 2022/03/28 14:06
-- Last Modified: 2022/10/23 02:28
--
--=====================================================================
vim.bo.expandtab = false
vim.cmd.compiler 'go'
vim.opt_local.conceallevel = 2
vim.opt_local.foldlevel = 3
vim.opt_local.formatoptions:remove 't'
