--=====================================================================
--
-- php.lua -
--
-- Created by liubang on 2022/08/06 00:25
-- Last Modified: 2022/08/06 00:25
--
--=====================================================================
local c = require "plugins.lsp.customs"
local M = {}

M.setup = function()
  -- lspconfig.phpactor.setup(c.default {
  --   init_options = {
  --     ['language_server_phpstan.enabled'] = true,
  --   },
  -- })
  require("lspconfig").intelephense.setup(c.default {})
end

return M
