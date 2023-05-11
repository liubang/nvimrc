--=====================================================================
--
-- lua_ls.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/12/07 22:35
--
--=====================================================================

local M = {}

function M.setup()
  local c = require "plugins.lsp.customs"
  require("lspconfig").lua_ls.setup(c.default {
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
  })
end

return M
