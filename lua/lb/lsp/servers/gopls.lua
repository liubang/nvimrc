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

local get_current_gomod = function()
  local file = io.open('go.mod', 'r')
  if file == nil then
    return nil
  end

  local first_line = file:read()
  local mod_name = first_line:gsub('module ', '')
  file:close()
  return mod_name
end

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
        linkTarget = 'pkg.go.dev',
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = 'Fuzzy',
        diagnosticsDelay = '500ms',
        experimentalWatchedFileDelay = '200ms',
        experimentalWorkspaceModule = true,
        experimentalPostfixCompletions = true,
        symbolMatcher = 'fuzzy',
        ['local'] = get_current_gomod(),
        gofumpt = true, -- true|false, -- turn on for new repos, gofmpt is good but also create code turmoils
        buildFlags = { '-tags', 'integration' },
      },
    },
  })
end

local org_imports = function(wait_ms)
  local codeaction = require('lb.lsp.lsp').codeaction
  codeaction('gopls', '', 'source.organizeImports', wait_ms)
  vim.lsp.buf.formatting_sync(nil, 5000)
end

return {
  setup = setup,
  org_imports = org_imports,
}
