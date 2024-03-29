--=====================================================================
--
-- latex.lua -
--
-- Created by liubang on 2023/11/30 23:34
-- Last Modified: 2023/11/30 23:34
--
--=====================================================================
local c = require("plugins.lsp.customs")
local lspconfig = require("lspconfig")
local is_mac = vim.loop.os_uname().version:match("Darwin")

local forwardSearch = {}
if not is_mac then
  forwardSearch = {
    executable = "zathura",
    args = { "--synctex-forward", "%l:1:%f", "%p" },
  }
else
  forwardSearch = {
    executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
    args = { "%l", "%p", "%f" },
  }
end
lspconfig.texlab.setup(c.default({
  flags = { allow_incremental_sync = false },
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
          -- "-pv",
          "-f",
          "-outdir=build",
          "%f",
        },
        onSave = true,
        forwardSearchAfter = false,
      },
      auxDirectory = "build",
      diagnosticsDelay = 50,
      forwardSearch = forwardSearch,
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
}))
