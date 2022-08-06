-- =====================================================================
--
-- commands.lua -
--
-- Created by liubang on 2020/12/12 18:32
-- Last Modified: 2022/04/05 03:55
--
-- =====================================================================
vim.schedule(function()
  vim.api.nvim_create_user_command('Filepath', function()
    print(vim.fn.expand '%:p')
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

  vim.api.nvim_create_user_command('Tasks', function()
    require('telescope').extensions.tasks.tasks()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelRules', function()
    require('telescope').extensions.bazel.bazel_rules()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelTests', function()
    require('telescope').extensions.bazel.bazel_tests()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelBinaries', function()
    require('telescope').extensions.bazel.bazel_binaries()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelCCRules', function()
    require('telescope').extensions.bazel.bazel_cc_rules()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelCCTests', function()
    require('telescope').extensions.bazel.bazel_cc_tests()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelCCBinaries', function()
    require('telescope').extensions.bazel.bazel_cc_binaries()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('LspDebug', function()
    vim.lsp.set_log_level 'debug'
  end, { nargs = 0 })
end)
