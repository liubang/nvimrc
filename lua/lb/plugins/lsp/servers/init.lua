--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/10/16 15:50
--
--=====================================================================

local lspconfig = require 'lspconfig'
local c = require 'lb.plugins.lsp.customs'

for _, server in ipairs {
  'jsonls',
  'yamlls',
  'clangd',
  'gopls',
  'rust',
  'sumneko_lua',
  'null-ls',
} do
  require('lb.plugins.lsp.servers.' .. server).setup()
end

-- some others use default config
for _, server in ipairs {
  'bashls',
  'cmake',
  'texlab',
  'vimls',
  'cssls',
  'tsserver',
  'pyright',
} do
  lspconfig[server].setup(c.default())
end
