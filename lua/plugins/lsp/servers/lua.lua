--=====================================================================
--
-- lua.lua -
--
-- Created by liubang on 2023/11/30 23:33
-- Last Modified: 2023/11/30 23:33
--
--=====================================================================
local c = require("plugins.lsp.customs")
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup(c.default({
  settings = {
    Lua = {
      hint = {
        arrayIndex = "Disable",
        enable = true,
        setType = true,
      },
      workspace = {
        ignoreDir = "tmp/",
        useGitIgnore = false,
        maxPreload = 100000000,
        preloadFileSize = 500000,
        checkThirdParty = false,
      },
      completion = { callSnippet = "Replace" },
      format = { enable = false },
    },
  },
}))
