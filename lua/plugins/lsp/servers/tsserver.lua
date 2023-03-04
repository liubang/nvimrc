--=====================================================================
--
-- tsserver.lua -
--
-- Created by liubang on 2023/02/05 00:56
-- Last Modified: 2023/02/05 00:56
--
--=====================================================================
local c = require "plugins.lsp.customs"
local M = {}

function M.setup()
  require("typescript").setup {
    server = c.default {
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    },
  }
end

return M
