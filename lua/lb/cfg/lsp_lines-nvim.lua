--=====================================================================
--
-- lsp_lines-nvim.lua -
--
-- Created by liubang on 2022/10/23 02:40
-- Last Modified: 2022/10/23 02:40
--
--=====================================================================

local lsp_lines = require 'lsp_lines'
lsp_lines.setup()
local opt = { buffer = true, desc = 'toggle lsp_lines' }
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
    vim.keymap.set('', '<Leader>l', lsp_lines.toggle, opt)
  end,
})
lsp_lines.toggle()
