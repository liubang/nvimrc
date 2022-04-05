-- =====================================================================
--
-- events.lua -
--
-- Created by liubang on 2021/07/25 20:20
-- Last Modified: 2021/07/25 20:20
--
-- =====================================================================

vim.api.nvim_create_augroup('CustomLspEvents', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'CustomLspEvents',
  pattern = '*.go',
  callback = function()
    GoOrgImports(1000)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'CustomLspEvents',
  pattern = 'java',
  callback = function()
    require('lb.lsp.jdtls.setup').setup()
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = 'CustomLspEvents',
  pattern = { '*.java' },
  callback = function()
    require('lb.lsp.jdtls.setup').organize_imports()
  end,
})

vim.api.nvim_create_autocmd('BufReadCmd', {
  group = 'CustomLspEvents',
  pattern = 'jdt://*',
  callback = function()
    print(vim.fn.expand '<amatch>')
    require('lb.lsp.jdtls.setup').open_jdt_link(vim.fn.expand '<amatch>')
  end,
})
