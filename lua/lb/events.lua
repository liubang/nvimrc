-- =====================================================================
--
-- events.lua -
--
-- Created by liubang on 2020/12/12 13:04
-- Last Modified: 2020/12/12 13:04
--
-- =====================================================================
-- clear augroup vimrc
vim.cmd [[augroup vimrc]]
vim.cmd [[  autocmd!]]
vim.cmd [[augroup END]]

-- augroup user_events
vim.cmd [[augroup user_events]]
vim.cmd [[  autocmd!]]
vim.cmd [[  autocmd WinEnter     * if &filetype == 'NvimTree' && winnr('$') == 1 | q | endif]]
vim.cmd [[  autocmd BufReadPost  * if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' | exe "normal! g'\"" | endif]]
vim.cmd [[  autocmd BufWritePost * nested if &l:filetype ==# '' || exists('b:ftdetect') | unlet! b:ftdetect | filetype detect | endif]]
vim.cmd [[  autocmd TextYankPost * lua vim.highlight.on_yank{timeout = 500, on_visual = true}]]
-- vim.cmd [[  autocmd CursorHold   * lua vim.lsp.diagnostic.show_line_diagnostics()]]
vim.cmd [[augroup END]]
