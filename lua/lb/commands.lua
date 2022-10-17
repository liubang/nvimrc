-- =====================================================================
--
-- commands.lua -
--
-- Created by liubang on 2020/12/12 18:32
-- Last Modified: 2022/10/17 22:52
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

vim.api.nvim_create_user_command('GoAddTagsJson', function()
  require('lb.go.tags').add('json', '-transform', 'snakecase', '--skip-unexported')
end, { nargs = 0 })

vim.api.nvim_create_user_command('GoAddTagsXml', function()
  require('lb.go.tags').add('xml', '-transform', 'snakecase', '--skip-unexported')
end, { nargs = 0 })

vim.api.nvim_create_user_command('GoRmTagsJson', function()
  require('lb.go.tags').rm 'json'
end, { nargs = 0 })

vim.api.nvim_create_user_command('GoRmTagsXml', function()
  require('lb.go.tags').rm 'xml'
end, { nargs = 0 })

vim.api.nvim_create_user_command('GoImpl', function(opts)
  require('lb.go.impl').run(unpack(opts.fargs))
end, { complete = require('lb.go.impl').complete, nargs = '*' })

vim.api.nvim_create_user_command('GoTestFile', function()
  require('lb.go.gotest').run_file()
end, { nargs = 0 })

vim.api.nvim_create_user_command('GoTest', function()
  require('lb.go.gotest').list_tests()
end, { nargs = 0 })

vim.api.nvim_create_user_command('GoMockGen', require('lb.go.mockgen').run, {
  nargs = '*',
  complete = function(_, _, _)
    return { '-p', '-d', '-i', '-s' }
  end,
})
