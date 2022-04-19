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
    vim.fn.expand '%:p'
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('CopyRight', function()
    require('lb.utils.comment').copy_right 'liubang'
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('CopyRightUpdate', function()
    require('lb.utils.comment').copy_right_update()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('Tasks', function()
    require('telescope').extensions.tasks.tasks()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelRules', function()
    require('telescope').expand.bazel.bazel_rules()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelTests', function()
    require('telescope').expand.bazel.bazel_tests()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelBinaries', function()
    require('telescope').expand.bazel.bazel_binaries()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelCCRules', function()
    require('telescope').expand.bazel.bazel_cc_rules()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelCCTests', function()
    require('telescope').expand.bazel.bazel_cc_tests()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('BazelCCBinaries', function()
    require('telescope').expand.bazel.bazel_cc_binaries()
  end, { nargs = 0 })

  vim.api.nvim_create_user_command('LspDebug', function()
    vim.lsp.set_log_level 'debug'
  end, { nargs = 0 })
end)
