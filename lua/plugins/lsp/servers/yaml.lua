--=====================================================================
--
-- yaml.lua -
--
-- Created by liubang on 2023/11/30 23:36
-- Last Modified: 2023/11/30 23:36
--
--=====================================================================
local c = require("plugins.lsp.customs")
local lspconfig = require("lspconfig")

lspconfig.yamlls.setup(c.default({
  settings = {
    yaml = {
      format = { enable = true, singleQuote = true },
      validate = true,
      hover = true,
      completion = true,
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}))
