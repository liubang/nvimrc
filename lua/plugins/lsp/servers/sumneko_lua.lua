--=====================================================================
--
-- sumneko_lua.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/12/07 22:35
--
--=====================================================================

local M = {}

function M.setup()
  require "neodev"

  local c = require "plugins.lsp.customs"
  require("lspconfig").sumneko_lua.setup(c.default {
    settings = {
      Lua = {
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
