-- =====================================================================
--
-- events.lua -
--
-- Created by liubang on 2021/07/25 20:20
-- Last Modified: 2021/07/25 20:20
--
-- =====================================================================

local lsp_events_group = vim.api.nvim_create_augroup('LSP_EVENTS', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = lsp_events_group,
  pattern = '*.go',
  callback = function()
    require('lb.plugins.lsp.servers.gopls').org_imports(5000)
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = lsp_events_group,
  pattern = 'go.mod',
  callback = function(args)
    local filename = vim.fn.expand '%:p'
    require('lb.go.gopls').tidy()
    -- lsp.go_mod_tidy(tonumber(args.buf), filename)
  end,
  desc = 'run go mod tidy on save',
})
