-- Copyright (c) 2026 The Authors. All rights reserved.
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

local jutils = require("plugins.java.utils")

local on_attach = function(client, bufnr) --- {{{
  client.server_capabilities.semanticTokensProvider = nil
  client.server_capabilities.workspaceSymbolProvider = false

  local function run_cmd(cmd)
    return function()
      vim.cmd(cmd)
    end
  end

  local function code_action(only)
    return function()
      vim.lsp.buf.code_action({
        context = { only = { only } },
        apply = true,
      })
    end
  end

  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "<leader>jb", run_cmd("JavaBuildBuildWorkspace"), vim.tbl_extend("force", opts, { desc = "Java build workspace" }))
  vim.keymap.set("n", "<leader>jc", run_cmd("JavaBuildCleanWorkspace"), vim.tbl_extend("force", opts, { desc = "Java clean workspace" }))
  vim.keymap.set("n", "<leader>jr", run_cmd("JavaRunnerRunMain"), vim.tbl_extend("force", opts, { desc = "Java run main" }))
  vim.keymap.set("n", "<leader>jR", run_cmd("JavaRunnerStopMain"), vim.tbl_extend("force", opts, { desc = "Java stop main" }))
  vim.keymap.set("n", "<leader>jl", run_cmd("JavaRunnerToggleLogs"), vim.tbl_extend("force", opts, { desc = "Java toggle logs" }))
  vim.keymap.set("n", "<leader>jt", run_cmd("JavaTestRunCurrentMethod"), vim.tbl_extend("force", opts, { desc = "Java test current method" }))
  vim.keymap.set("n", "<leader>jT", run_cmd("JavaTestDebugCurrentMethod"), vim.tbl_extend("force", opts, { desc = "Java debug current method" }))
  vim.keymap.set("n", "<leader>ja", run_cmd("JavaTestRunAllTests"), vim.tbl_extend("force", opts, { desc = "Java run all tests" }))
  vim.keymap.set("n", "<leader>jA", run_cmd("JavaTestDebugAllTests"), vim.tbl_extend("force", opts, { desc = "Java debug all tests" }))
  vim.keymap.set("n", "<leader>jp", run_cmd("JavaProfile"), vim.tbl_extend("force", opts, { desc = "Java profiles" }))
  vim.keymap.set("n", "<leader>jo", code_action("source.organizeImports"), vim.tbl_extend("force", opts, { desc = "Java organize imports" }))
end --- }}}

local M = {}

M.jdtls_config = function()
  return {
    on_attach = on_attach,
    settings = {
      java = {
        format = { enabled = true, settings = jutils.fmt_config() },
        autobuild = { enabled = false },
        maxConcurrentBuilds = 8,
        project = { encoding = "UTF-8" },
        foldingRange = { enabled = true },
        selectionRange = { enabled = true },
        inlayhints = { parameterNames = { enabled = "ALL" } },
        referencesCodeLens = { enabled = false }, -- 引用计数
        implementationsCodeLens = { enabled = false },
        codeLens = { enabled = false },
        eclipse = { downloadSources = false },
        maven = { downloadSources = false, updateSnapshots = false },
        signatureHelp = { enabled = false, description = { enabled = false } },
        contentProvider = { preferred = "fernflower" },
        saveActions = { organizeImports = false },
        semanticHighlighting = { enabled = false },
        sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
        configuration = {
          maven = { userSettings = jutils.maven_settings() },
          runtimes = jutils.runtimes(),
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
          },
          hashCodeEquals = {
            useJava7Objects = false,
            useInstanceOf = true,
          },
          useBlocks = true,
          addFinalForNewDeclaration = "fields",
        },
        import = {
          gradle = { enabled = true },
          maven = { enabled = true },
          exclusions = {
            "**/.git/**",
            "**/.idea/**",
            "**/.settings/**",
            "**/.metadata/**",
            "**/target/**",
            "**/node_modules/**",
            "**/archetype-resources/**",
            "**/META-INF/maven/**",
          },
        },
        templates = {
          typeComment = {
            "/**",
            " * ${type_name}.",
            " *",
            " * @author ${user}",
            " */",
          },
        },
        completion = {
          favoriteStaticMembers = {
            "org.junit.Assert.*",
            "org.junit.Assume.*",
            "org.junit.jupiter.api.Assertions.*",
            "org.junit.jupiter.api.Assumptions.*",
            "org.junit.jupiter.api.DynamicContainer.*",
            "org.junit.jupiter.api.DynamicTest.*",
            "org.assertj.core.api.Assertions.assertThat",
            "org.assertj.core.api.Assertions.assertThatThrownBy",
            "org.assertj.core.api.Assertions.assertThatExceptionOfType",
            "org.assertj.core.api.Assertions.catchThrowable",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*",
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "org.graalvm.*",
            "jdk.*",
            "sun.*",
          },
          importOrder = {
            "java",
            "javax",
            "org",
            "com",
          },
        },
      },
    },
  }
end

return M

-- vim: fdm=marker fdl=0
