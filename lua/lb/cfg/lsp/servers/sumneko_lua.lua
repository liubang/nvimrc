--=====================================================================
--
-- sumneko_lua.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/08/06 00:26
--
--=====================================================================
local lspconfig = require 'lspconfig'
local c = require 'lb.cfg.lsp.customs'

vim.cmd.packadd 'neodev.nvim'

local setup = function()
  require('neodev').setup {
    library = {
      enabled = true, -- when not enabled, lua-dev will not change any settings to the LSP server
      runtime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      plugins = true, -- installed opt or start plugins in packpath
    },
  }
  lspconfig.sumneko_lua.setup(c.default())
end

return {
  setup = setup,
}
