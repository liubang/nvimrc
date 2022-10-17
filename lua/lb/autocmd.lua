--=====================================================================
--
-- autocmd.lua -
--
-- Created by liubang on 2022/10/18 00:39
-- Last Modified: 2022/10/18 00:39
--
--=====================================================================

local filetype_commands_group = vim.api.nvim_create_augroup('FILETYPE_COMMANDS', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = filetype_commands_group,
  desc = 'highlihgt yanking',
  callback = function()
    vim.highlight.on_yank { higroup = 'Substitute', timeout = 300 }
  end,
})
