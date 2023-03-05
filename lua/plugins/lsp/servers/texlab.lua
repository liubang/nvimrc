--=====================================================================
--
-- texlab.lua -
--
-- Created by liubang on 2023/03/05 13:18
-- Last Modified: 2023/03/05 13:18
--
--=====================================================================

local c = require "plugins.lsp.customs"
local M = {}

M.setup = function()
  require("lspconfig").texlab.setup(c.default {
    settings = {
      texlab = {
        rootDirectory = nil,
        build = {
          executable = "latexmk",
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          onSave = true,
          forwardSearchAfter = false,
        },
        auxDirectory = ".",
        forwardSearch = {
          executable = "zathura",
          args = { "--synctex-forward", "%l:1:%f", "%p" },
        },
        chktex = {
          onOpenAndSave = false,
          onEdit = false,
        },
        diagnosticsDelay = 300,
        latexFormatter = "latexindent",
        latexindent = {
          ["local"] = nil, -- local is a reserved keyword
          modifyLineBreaks = false,
        },
        bibtexFormatter = "texlab",
        formatterLineLength = 80,
      },
    },
  })
end

return M
