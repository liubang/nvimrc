--=====================================================================
--
-- php.lua -
--
-- Created by liubang on 2022/08/06 00:25
-- Last Modified: 2022/08/06 00:25
--
--=====================================================================
local lspconfig = require 'lspconfig'
local c = require 'lb.lsp.customs'

local setup = function()
  lspconfig.phpactor.setup(c.default {
    init_options = {
      ['language_server_phpstan.enabled'] = true,
    },
  })
end

return {
  setup = setup,
}
