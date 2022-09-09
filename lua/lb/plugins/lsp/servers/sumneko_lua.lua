--=====================================================================
--
-- sumneko_lua.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/08/06 00:26
--
--=====================================================================
local lspconfig = require 'lspconfig'
local c = require 'lb.plugins.lsp.customs'

local setup = function()
  require('lua-dev').setup {
    library = {
      enabled = true, -- when not enabled, lua-dev will not change any settings to the LSP server
      -- these settings will be used for your neovim config directory
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
