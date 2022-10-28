-- =====================================================================
--
-- commands.lua -
--
-- Created by liubang on 2020/12/12 18:32
-- Last Modified: 2022/10/29 02:08
--
-- =====================================================================

vim.api.nvim_create_user_command('Filepath', function()
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.notify(vim.fn.expand '%:p', vim.lsp.log_levels.INFO, {
    title = 'Filename',
    timeout = 3000,
  })
end, { nargs = 0 })

vim.api.nvim_create_user_command('YankFilename', function()
  vim.fn.setreg('"', vim.fn.expand '%:t')
end, { nargs = 0 })

vim.api.nvim_create_user_command('YankFilepath', function()
  vim.fn.setreg('"', vim.fn.expand '%:p')
end, { nargs = 0 })

vim.api.nvim_create_user_command('CopyRight', function()
  require('lb.utils.comment').copy_right 'liubang'
end, { nargs = 0 })

vim.api.nvim_create_user_command('CopyRightUpdate', function()
  require('lb.utils.comment').copy_right_update()
end, { nargs = 0 })

vim.api.nvim_create_user_command('TrimWhiteSpace', function()
  require('lb.utils.util').trim_whitespace()
end, { nargs = 0 })
