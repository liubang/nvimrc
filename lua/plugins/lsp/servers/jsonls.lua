--=====================================================================
--
-- jsonls.lua -
--
-- Created by liubang on 2022/10/16 14:02
-- Last Modified: 2022/10/16 14:02
--
--=====================================================================

local c = require "plugins.lsp.customs"

local setup = function()
  require("lspconfig").jsonls.setup(c.default {
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
