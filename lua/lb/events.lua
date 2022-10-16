-- =====================================================================
--
-- events.lua -
--
-- Created by liubang on 2020/12/12 13:04
-- Last Modified: 2020/12/12 13:04
--
-- =====================================================================

local filetype_commands_group = vim.api.nvim_create_augroup('FILETYPE_COMMANDS', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = filetype_commands_group,
  desc = 'highlihgt yanking',
  callback = function()
    vim.highlight.on_yank { higroup = 'Substitute', timeout = 300 }
  end,
})
