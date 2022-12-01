--=====================================================================
--
-- sumneko_lua.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/12/01 23:57
--
--=====================================================================
local lspconfig = require 'lspconfig'
local c = require 'lb.cfg.lsp.customs'

local setup = function()
  lspconfig.sumneko_lua.setup(c.default {
    settings = {
      Lua = {
        telemetry = { enable = false },
        runtime = { version = 'LuaJIT' },
        diagnostics = {
          globals = { 'vim', 'packer_plugins', 'planery' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
      },
    },
  })
end

return {
  setup = setup,
}
