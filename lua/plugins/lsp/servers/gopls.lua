--=====================================================================
--
-- gopls.lua -
--
-- Created by liubang on 2022/08/06 00:23
-- Last Modified: 2022/12/08 17:33
--
--=====================================================================
local c = require "plugins.lsp.customs"

local setup = function()
  require("lspconfig").gopls.setup(c.default {
    -- share the gopls instance if there is one already
    cmd = { "gopls", "-remote.debug=:0" },
    filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
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
          regenerate_cgo = true,
          run_vulncheck_exp = true,
          upgrade_dependency = true,
        },
        directoryFilters = {
          "-**/node_modules",
          "-/tmp",
        },
        usePlaceholders = true,
        verboseOutput = false, -- useful for debugging when true.
        semanticTokens = true,
        completeUnimported = true,
        completionDocumentation = true,
        staticcheck = true,
        gofumpt = true,
        linksInHover = true,
        buildFlags = { "-tags=integration,e2e" },
      },
    },
  })
end

return {
  setup = setup,
}
