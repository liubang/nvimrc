--=====================================================================
--
-- vue.lua -
--
-- Created by liubang on 2023/01/04 00:36
-- Last Modified: 2023/01/04 00:36
--
--=====================================================================

local M = {}
local c = require "plugins.lsp.customs"

M.setup = function()
  require("lspconfig").vuels.setup(c.default {
    settings = {
      vetur = {
        completion = {
          autoImport = true,
          useScaffoldSnippets = true,
        },
        format = {
          defaultFormatter = {
            html = "none",
            js = "prettier",
            ts = "prettier",
          },
        },
        validation = {
          template = true,
          script = true,
          style = true,
          templateProps = true,
          interpolation = true,
        },
        experimental = {
          templateInterpolationService = true,
        },
      },
    },
  })
end

return M
