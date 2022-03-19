-- =====================================================================
--
-- events.lua -
--
-- Created by liubang on 2020/12/12 13:04
-- Last Modified: 2020/12/12 13:04
--
-- =====================================================================

vim.api.nvim_create_augroup('user_events', { clear = true })
vim.api.nvim_create_autocmd('WinEnter', {
  pattern = '*',
  group = 'user_events',
  command = [[if &filetype == 'NvimTree' && winnr('$') == 1 | q | endif]],
})
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  group = 'user_events',
  command = [[
    if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' | exe "normal! g'\"" | endif
  ]],
})
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = 'user_events',
  callback = function()
    vim.highlight.on_yank { timeout = 500, on_visual = true }
  end,
})
