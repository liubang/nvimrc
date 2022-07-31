-- =====================================================================
--
-- events.lua -
--
-- Created by liubang on 2020/12/12 13:04
-- Last Modified: 2020/12/12 13:04
--
-- =====================================================================

vim.api.nvim_create_augroup('user_events', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  group = 'user_events',
  callback = function()
    vim.highlight.on_yank { timeout = 500, on_visual = true }
  end,
})
