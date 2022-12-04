--=====================================================================
--
-- jsonls.lua -
--
-- Created by liubang on 2022/10/16 14:02
-- Last Modified: 2022/10/16 14:02
--
--=====================================================================

vim.cmd.packadd "schemastore.nvim"

local c = require "lb.cfg.lsp.customs"
local lspconfig = require "lspconfig"

local setup = function()
  lspconfig.jsonls.setup(c.default {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })
end

return {
  setup = setup,
}
