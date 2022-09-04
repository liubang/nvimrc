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
    require('lb.plugins.lsp.servers.gopls').org_imports(5000)
  end,
})
