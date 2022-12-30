--=====================================================================
--
-- yamlls.lua -
--
-- Created by liubang on 2022/10/16 14:07
-- Last Modified: 2022/12/07 19:49
--
--=====================================================================

local c = require "lb.plugins.lsp.customs"
local lspconfig = require "lspconfig"

local schemas = {
  kubernetes = {
    "templates/*.yaml",
    "helm/*.yaml",
    "kube/*.yaml",
  },
  ["https://json.schemastore.org/clang-format.json"] = ".clang-format",
  ["http://json.schemastore.org/golangci-lint.json"] = ".golangci.{yml,yaml}",
  ["http://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
  ["http://json.schemastore.org/github-action.json"] = ".github/action.{yml,yaml}",
  ["http://json.schemastore.org/ansible-stable-2.9.json"] = "roles/tasks/*.{yml,yaml}",
  ["http://json.schemastore.org/ansible-playbook.json"] = "playbook.{yml,yaml}",
  ["http://json.schemastore.org/prettierrc.json"] = ".prettierrc.{yml,yaml}",
  ["http://json.schemastore.org/stylelintrc.json"] = ".stylelintrc.{yml,yaml}",
  ["http://json.schemastore.org/circleciconfig.json"] = ".circleci/**/*.{yml,yaml}",
  ["http://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
  ["http://json.schemastore.org/helmfile.json"] = "templates/**/*.{yml,yaml}",
  ["http://json.schemastore.org/chart.json"] = "Chart.yml,yaml}",
  ["http://json.schemastore.org/gitlab-ci.json"] = "/*lab-ci.{yml,yaml}",
  ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "templates/**/*.{yml,yaml}",
  ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.{yml,yaml}",
}

local setup = function()
  lspconfig.yamlls.setup(c.default {
    settings = {
      yaml = {
        format = { enable = true, singleQuote = true },
        validate = true,
        hover = true,
        completion = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemas = schemas,
      },
    },
  })
end

return {
  setup = setup,
}
