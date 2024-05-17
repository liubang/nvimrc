-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

local c = require("plugins.lsp.customs")
local lspconfig = require("lspconfig")

local get_current_gomod = function()
  local file = io.open("go.mod", "r")
  if file == nil then
    return nil
  end

  local first_line = file:read()
  local mod_name = first_line:gsub("module ", "")
  file:close()
  return mod_name
end

lspconfig.gopls.setup(c.default({
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
      ["local"] = get_current_gomod(),
      semanticTokens = true,
      usePlaceholders = true,
      completeUnimported = true,
      completionDocumentation = true,
      staticcheck = true,
      gofumpt = true,
      linksInHover = true,
      buildFlags = { "-tags", "integration" },
    },
  },
}))
