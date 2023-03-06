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
    flags = {
      allow_incremental_sync = false,
    },
    settings = {
      texlab = {
        rootDirectory = nil,
        build = {
          executable = "latexmk",
          args = {
            "-xelatex",
            "-file-line-error",
            "-halt-on-error",
            "-interaction=nonstopmode",
            "-synctex=1",
            "-shell-escape",
            "-f",
            "-outdir=build",
            "%f",
          },
          onSave = true,
          forwardSearchAfter = false,
        },
        auxDirectory = "build",
        diagnosticsDelay = 50,
        forwardSearch = {
          executable = "zathura",
          args = { "--synctex-forward", "%l:1:%f", "%p" },
        },
        chktex = { onOpenAndSave = true, onEdit = false },
        formatterLineLength = 120,
        -- latexFormatter = "latexindent",
        -- latexindent = {
        --   ["local"] = nil, -- local is a reserved keyword
        --   modifyLineBreaks = false,
        -- },
        -- bibtexFormatter = "texlab",
      },
    },
  })
end

return M
