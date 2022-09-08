--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/08/06 00:26
--
--=====================================================================

local lspconfig = require 'lspconfig'
local c = require 'lb.plugins.lsp.customs'

for _, server in ipairs {
  'clangd',
  'gopls',
  -- 'php',
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
  'jsonls',
  'yamlls',
} do
  lspconfig[server].setup(c.default())
end
