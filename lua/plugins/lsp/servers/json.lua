--=====================================================================
--
-- json.lua -
--
-- Created by liubang on 2023/11/30 23:36
-- Last Modified: 2023/11/30 23:36
--
--=====================================================================
local c = require("plugins.lsp.customs")
local lspconfig = require("lspconfig")

lspconfig.jsonls.setup(c.default({
  settings = {
    json = {
      validate = { enable = true },
      format = { enable = true },
    },
  },
  -- Lazy-load schemas.
  on_new_config = function(config)
    config.settings.json.schemas = config.settings.json.schemas or {}
    vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
  end,
}))
