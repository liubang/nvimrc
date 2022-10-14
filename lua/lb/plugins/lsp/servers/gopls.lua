--=====================================================================
--
-- gopls.lua -
--
-- Created by liubang on 2022/08/06 00:23
-- Last Modified: 2022/08/06 00:23
--
--=====================================================================
local lspconfig = require 'lspconfig'
local c = require 'lb.plugins.lsp.customs'

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
          asmdecl = true, -- report mismatches between assembly files and Go declarations
          assign = true, -- check for useless assignments
          atomic = true, -- check for common mistakes using the sync/atomic package
          atomicalign = true, -- check for non-64-bits-aligned arguments to sync/atomic functions
          bools = true,
          buildtag = true,
          cgocall = true,
          composites = true,
          copylocks = true,
          deepequalerrors = true,
          embed = true,
          errorsas = true,
          fieldalignment = true,
          httpresponse = true,
          ifaceassert = true,
          infertypeargs = true,
          loopclosure = true,
          lostcancel = true,
          nilfunc = true,
          nilness = true,
          printf = true,
          shadow = true,
          shift = true,
          simplifycompositelit = true,
          simplifyrange = true,
          simplifyslice = true,
          sortslice = true,
          stdmethods = true,
          stringintconv = true,
          structtag = true,
          testinggoroutine = true,
          tests = true,
          timeformat = true,
          unmarshal = true,
          unreachable = true,
          unsafeptr = true,
          unusedparams = true,
          unusedresult = true,
          unusedwrite = true,
          useany = true,
          fillreturns = true,
          nonewvars = true,
          noresultvalues = true,
          undeclaredname = true,
          unusedvariable = true,
          fillstruct = true,
          stubmethods = true,
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
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        -- ['local'] = get_current_gomod(),
        gofumpt = true,
      },
    },
  })
end

local org_imports = function(wait_ms)
  local codeaction = require('lb.lsp.lsp').codeaction
  codeaction('gopls', '', 'source.organizeImports', wait_ms)
  vim.lsp.buf.format { async = false, timeout_ms = wait_ms }
end

return {
  setup = setup,
  org_imports = org_imports,
}
