-- =====================================================================
--
-- vim-cursorword.lua - 
--
-- Created by liubang on 2020/12/13 16:06
-- Last Modified: 2020/12/13 16:06
--
-- =====================================================================
vim.cmd [[augroup user_plugin_cursorword]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd FileType LuaTree,defx,denite,fern,clap,vista let b:cursorword = 0]]
vim.cmd [[  autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif]]
vim.cmd [[  autocmd InsertEnter * let b:cursorword = 0]]
vim.cmd [[  autocmd InsertLeave * let b:cursorword = 1]]
vim.cmd [[augroup END]]
