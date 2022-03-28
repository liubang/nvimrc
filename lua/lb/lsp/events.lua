-- =====================================================================
--
-- events.lua -
--
-- Created by liubang on 2021/07/25 20:20
-- Last Modified: 2021/07/25 20:20
--
-- =====================================================================

vim.api.nvim_create_augroup('custom_lsp_events', { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'custom_lsp_events',
  pattern = '*.go',
  callback = function()
    GoOrgImports(1000)
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'custom_lsp_events',
  pattern = '*.java',
  callback = function()
    require('jdtls').organize_imports()
  end,
})

vim.api.nvim_create_autocmd('BufReadCmd', {
  group = 'custom_lsp_events',
  pattern = 'jdt://* ',
  callback = function()
    require('jdtls').open_jdt_link(vim.fn.expand '<amatch>')
  end,
})
