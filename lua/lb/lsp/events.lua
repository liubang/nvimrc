-- =====================================================================
--
-- events.lua - 
--
-- Created by liubang on 2021/07/25 20:20
-- Last Modified: 2021/07/25 20:20
--
-- =====================================================================
vim.cmd [[augroup lsp]]
vim.cmd [[  autocmd! ]]
vim.cmd [[  autocmd BufWritePre *.go lua GoOrgImports(1000) ]]
vim.cmd [[  autocmd BufWritePre *.java lua JavaOrgImports() ]]
vim.cmd [[augroup END]]
