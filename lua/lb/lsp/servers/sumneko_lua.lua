--=====================================================================
--
-- sumneko_lua.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/08/06 00:26
--
--=====================================================================
local lspconfig = require 'lspconfig'
local c = require 'lb.lsp.customs'

local setup = function()
  lspconfig.sumneko_lua.setup(c.default(require('lua-dev').setup()))
end

return {
  setup = setup,
}
