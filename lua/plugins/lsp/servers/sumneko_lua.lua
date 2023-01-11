--=====================================================================
--
-- sumneko_lua.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/12/07 22:35
--
--=====================================================================

local c = require "plugins.lsp.customs"

local setup = function()
  require("neodev").setup {
    experimental = { pathStrict = true },
  }

  require("lspconfig").sumneko_lua.setup(c.default {
    single_file_support = true,
    settings = {
      Lua = {
        format = {
          enable = false,
        },
        completion = {
          workspaceWord = true,
          callSnippet = "Both",
        },
        workspace = {
          checkThirdParty = false,
        },
        diagnostics = {
          groupSeverity = {
            strong = "Warning",
            strict = "Warning",
          },
          groupFileStatus = {
            ["ambiguity"] = "Opened",
            ["await"] = "Opened",
            ["codestyle"] = "None",
            ["duplicate"] = "Opened",
            ["global"] = "Opened",
            ["luadoc"] = "Opened",
            ["redefined"] = "Opened",
            ["strict"] = "Opened",
            ["strong"] = "Opened",
            ["type-check"] = "Opened",
            ["unbalanced"] = "Opened",
            ["unused"] = "Opened",
          },
          unusedLocalExclude = { "_*" },
        },
      },
    },
  })
end

return {
  setup = setup,
}
