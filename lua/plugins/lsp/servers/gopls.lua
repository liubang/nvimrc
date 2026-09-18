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

local get_module_name = function(root_dir)
  if not root_dir or root_dir == "" then
    return nil
  end

  local gomod = root_dir .. "/go.mod"
  local file = io.open(gomod, "r")
  if file == nil then
    return nil
  end

  for line in file:lines() do
    local mod_name = line:match("^module%s+(.+)$")
    if mod_name then
      file:close()
      return mod_name
    end
  end

  file:close()
  return nil
end

return {
  -- share the gopls instance if there is one already
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gosum", "gotmpl", "gohtmltmpl", "gotexttmpl" },
  -- NOTE: on_new_config is a legacy nvim-lspconfig callback and is silently
  -- ignored by vim.lsp.config (0.11+). Use before_init instead, where
  -- config.root_dir is already resolved and settings mutations still make
  -- it into the initialize request.
  before_init = function(_, config)
    config.settings = config.settings or {}
    config.settings.gopls = config.settings.gopls or {}
    config.settings.gopls["local"] = get_module_name(config.root_dir)
  end,
  settings = {
    gopls = {
      analyses = {
        -- check analyzers for default values
        -- leeave most of them to default
        -- shadow = true,
        -- unusedvariable = true,
        useany = true,
      },
      -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
      codelenses = {
        generate = true, -- show the `go generate` lens.
        gc_details = true, -- Show a code lens toggling the display of gc's choices.
        test = true,
        tidy = true,
        regenerate_cgo = true,
        run_vulncheck_exp = true,
        upgrade_dependency = true,
      },
      semanticTokens = true,
      usePlaceholders = true,
      completeUnimported = true,
      completionDocumentation = true,
      staticcheck = true,
      gofumpt = true,
      linksInHover = true,
      vulncheck = "Imports",
      buildFlags = { "-tags", "integration" },
    },
  },
}
