--=====================================================================
--
-- gopls.lua -
--
-- Created by liubang on 2022/08/06 00:23
-- Last Modified: 2022/08/06 00:23
--
--=====================================================================
local lspconfig = require 'lspconfig'
local c = require 'lb.lsp.customs'

local setup = function()
  lspconfig.gopls.setup(c.default {
    -- share the gopls instance if there is one already
    cmd = { 'gopls', '-remote.debug=:0' },
    filetypes = { 'go', 'gomod', 'gosum', 'gotmpl', 'gohtmltmpl', 'gotexttmpl' },
    message_level = vim.lsp.protocol.MessageType.Error,
    flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
    settings = {
      gopls = {
        -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
        analyses = {
          unusedparams = true,
          unreachable = true,
          nilness = true,
          useany = true,
          unusedwrite = true,
          ST1003 = true,
          undeclaredname = true,
          fillreturns = true,
          nonewvars = true,
          fieldalignment = false,
          shadow = true,
        },
        codelenses = {
          generate = true, -- show the `go generate` lens.
          gc_details = true, -- Show a code lens toggling the display of gc's choices.
          test = true,
          tidy = true,
          vendor = true,
          regenerate_cgo = true,
          upgrade_dependency = true,
        },
        experimentalUseInvalidMetadata = true,
        hoverKind = 'FullDocumentation',
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = 'Fuzzy',
        diagnosticsDelay = '500ms',
        experimentalWatchedFileDelay = '200ms',
        symbolMatcher = 'fuzzy',
        gofumpt = true, -- true|false, -- turn on for new repos, gofmpt is good but also create code turmoils
        buildFlags = { '-tags', 'integration' },
      },
    },
  })
end

return {
  setup = setup,
}
