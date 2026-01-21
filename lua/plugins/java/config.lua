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
local u = require("lb.utils.util")
local jar_dir = vim.fn.stdpath("config") .. "/data/jars/"

local with_compile = function(client, bufnr, fn)
  return function()
    if vim.bo.modified then
      vim.cmd("w")
    end
    client.request_sync("java/buildWorkspace", false, 5000, bufnr)
    fn()
  end
end

local on_attach = function(client, bufnr)
  local jdtls = require("jdtls")
  jdtls.jol_path = jar_dir .. "jol-cli-0.17-full.jar"
  local create_command = vim.api.nvim_buf_create_user_command
  create_command(bufnr, "JavaRunLast", with_compile(client, bufnr, require("dap").run_last), { nargs = 0 })
  create_command(bufnr, "JavaTestClass", with_compile(client, bufnr, jdtls.test_class), { nargs = 0 })
  create_command(bufnr, "JavaTestNearestMethod", with_compile(client, bufnr, jdtls.test_nearest_method), { nargs = 0 })
  create_command(bufnr, "JavaPickTest", with_compile(client, bufnr, jdtls.pick_test), { nargs = 0 })
  create_command(bufnr, "JavaExtractVariable", jdtls.extract_variable, { nargs = 0 })
  create_command(bufnr, "JavaExtractConstant", jdtls.extract_constant, { nargs = 0 })
  -- stylua: ignore
  create_command(bufnr, "JavaExtractMethod", function() jdtls.extract_method(true) end, { nargs = 0 })
  create_command(bufnr, "JavaTestGenerate", require("jdtls.tests").generate, { nargs = 0 })
  create_command(bufnr, "JavaTestGoto", require("jdtls.tests").goto_subjects, { nargs = 0 })
  create_command(bufnr, "JavaProjects", require("java-deps").toggle_outline, { nargs = 0 })
  -- stylua: ignore
  create_command(bufnr, "JavaRun", with_compile(client, bufnr, 
    function() require("jdtls.dap").setup_dap_main_class_configs({verbose = false, on_ready = require('dap')['continue']}) end), { nargs = 0 })

  -- stylua: ignore
  create_command(bufnr, "JavaTestWithProfile", with_compile(client, bufnr, jutils.test_with_profile(jdtls.test_nearest_method)), { nargs = 0 })
  vim.keymap.set("n", "<leader>dM", with_compile(client, bufnr, jutils.test_with_profile(jdtls.test_nearest_method)))
end

local get_init_options = function()
  local opts = {
    bundles = {},
    extendedClientCapabilities = require("jdtls.capabilities"),
  }

  local mason = require("mason-registry")
  -- vscode-java-debug
  if mason.has_package("java-debug-adapter") then
    local java_debug_path = vim.fn.expand("$MASON/packages/java-debug-adapter/extension/server/")
    vim.list_extend(
      opts.bundles,
      vim.split(vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar"), "\n")
    )
  end

  -- vscode-java-test
  if mason.has_package("java-test") then
    local java_test_path = vim.fn.expand("$MASON/packages/java-test/extension/server")
    for _, bundle in ipairs(vim.split(vim.fn.glob(java_test_path .. "/*.jar"), "\n")) do
      if
        not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
        and not vim.endswith(bundle, "jacocoagent.jar")
      then
        table.insert(opts.bundles, bundle)
      end
    end
  end

  -- vscode-java-decompiler
  if mason.has_package("vscode-java-decompiler") then
    local java_decompiler_path = vim.fn.expand("$MASON/packages/vscode-java-decompiler/extension/server")
    vim.list_extend(opts.bundles, vim.split(vim.fn.glob(java_decompiler_path .. "/*.jar"), "\n"))
  end

  -- vscode-java-dependency
  if mason.has_package("vscode-java-dependency") then
    local java_dependency_path = vim.fn.expand("$MASON/packages/vscode-java-dependency/extension/server")
    vim.list_extend(opts.bundles, vim.split(vim.fn.glob(java_dependency_path .. "/*.jar"), "\n"))
  end

  -- 添加 spring-boot jdtls 扩展 jar 包
  vim.list_extend(opts.bundles, require("spring_boot").java_extensions())

  return opts
end

local jdtls_launcher = function()
  local jdtls_config = nil
  if u.is_linux then
    jdtls_config = "/config_linux"
  elseif u.is_mac then
    jdtls_config = "/config_mac"
  end
  if u.is_arm then
    jdtls_config = jdtls_config .. "_arm"
  end
  local cmd = {
    jutils.java_bin,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dosgi.checkConfiguration=true",
    "-Dosgi.sharedConfiguration.area=" .. vim.fn.glob(vim.fn.expand("$MASON/packages/jdtls/") .. jdtls_config),
    "-Dosgi.sharedConfiguration.area.readOnly=true",
    "-Dosgi.configuration.cascaded=true",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms512m",
    "-Xmx8g",
    "-XX:+UseG1GC",
    "-XX:MaxGCPauseMillis=200",
    "-XX:+UseStringDeduplication",
    "--enable-native-access=ALL-UNNAMED",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "--add-opens",
    "java.base/sun.nio.fs=ALL-UNNAMED",
  }
  table.insert(cmd, "-javaagent:" .. jar_dir .. "lombok.jar")
  table.insert(cmd, "-jar")
  table.insert(cmd, vim.fn.glob(vim.fn.expand("$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")))
  table.insert(cmd, "-data")
  table.insert(cmd, jutils.get_workspace_dir())
  return cmd
end

local M = {}

M.spring_boot_opts = function()
  return {
    autocmd = true,
    java_cmd = jutils.java_bin,
  }
end

M.jdtls_config = function()
  return {
    cmd = jdtls_launcher(),
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),
    on_attach = on_attach,
    init_options = get_init_options(),
    settings = {
      java = {
        format = { settings = jutils.fmt_config() },
        autobuild = { enabled = false },
        maxConcurrentBuilds = 8,
        project = { encoding = "UTF-8" },
        foldingRange = { enabled = true },
        selectionRange = { enabled = true },
        inlayhints = { parameterNames = { enabled = "ALL" } },
        referenceCodeLens = { enabled = true },
        implementationsCodeLens = { enabled = true },
        eclipse = { downloadSources = true },
        maven = { downloadSources = true, updateSnapshots = true },
        signatureHelp = { enabled = true, description = { enabled = true } },
        contentProvider = { preferred = "fernflower" },
        saveActions = { organizeImports = true },
        sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
        configuration = {
          maven = { userSettings = jutils.maven_settings() },
          runtimes = jutils.runtimes(),
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
