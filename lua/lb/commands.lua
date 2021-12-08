-- =====================================================================
--
-- commands.lua -
--
-- Created by liubang on 2020/12/12 18:32
-- Last Modified: 2020/12/12 18:32
--
-- =====================================================================
vim.schedule(function()
  vim.cmd [[command! -nargs=0 -bar Filepath echo expand('%:p')]]
  vim.cmd [[command! -nargs=0 -bar CopyRight :lua require('lb.utils.comment').copy_right('liubang')]]
  vim.cmd [[command! -nargs=0 -bar CopyRightUpdate :lua require('lb.utils.comment').copy_right_update()]]
  vim.cmd [[command! -nargs=0 -bar Tasks :lua require('telescope').extensions.tasks.tasks()<CR>]]
  vim.cmd [[command! -nargs=0 -bar BazelRules :lua require('telescope').extensions.bazel.bazel_rules()<CR>]]
  vim.cmd [[command! -nargs=0 -bar BazelTests :lua require('telescope').extensions.bazel.bazel_rules()<CR>]]
  vim.cmd [[command! -nargs=0 -bar BazelBinaries :lua require('telescope').extensions.bazel.bazel_rules()<CR>]]
  vim.cmd [[command! -nargs=0 -bar BazelCCRules :lua require('telescope').extensions.bazel.bazel_cc_rules()<CR>]]
  vim.cmd [[command! -nargs=0 -bar BazelCCTests :lua require('telescope').extensions.bazel.bazel_cc_tests()<CR>]]
  vim.cmd [[command! -nargs=0 -bar BazelCCBinaries :lua require('telescope').extensions.bazel.bazel_cc_binaries()<CR>]]
  vim.cmd [[command! -nargs=0 -bar Projects :lua require('telescope').extensions.project.project({change_dir = true})<CR>]]
  vim.cmd [[command! -nargs=0 -bar LspDebug :lua vim.lsp.set_log_level("debug")<CR>]]
end)
