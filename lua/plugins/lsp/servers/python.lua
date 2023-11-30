--=====================================================================
--
-- python.lua -
--
-- Created by liubang on 2023/11/30 23:33
-- Last Modified: 2023/11/30 23:33
--
--=====================================================================

local c = require("plugins.lsp.customs")
local lspconfig = require("lspconfig")

lspconfig.pyright.setup(c.default({
  single_file_support = true,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
      },
    },
  },
}))
