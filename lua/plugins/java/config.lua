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

local uv = vim.uv
local uname = uv.os_uname()
local utils = require("plugins.java.utils")
local data_dir = vim.fn.stdpath("data")
local jar_dir = vim.fn.stdpath("config") .. "/data/jars/"

local get_javaagent = function()
  return jar_dir .. "/lombok.jar"
end

local get_jdtls_cfg_dir = function()
  local cfg_dir = "config"
  if uname.sysname == "Linux" then
    cfg_dir = cfg_dir .. "_linux"
  elseif uname.sysname == "Darwin" then
    cfg_dir = cfg_dir .. "_mac"
  end

  if uname.machine == "arm64" then
    cfg_dir = cfg_dir .. "_arm"
  end
  return data_dir .. "/mason/packages/jdtls/" .. cfg_dir
end

local get_launcher_files = function()
  return vim.fn.glob(data_dir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", true, true)[1]
end

local get_workspace_dir = function()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name
end

local on_attach = function(client, bufnr)
  local jdtls = require("jdtls")
  jdtls.jol_path = vim.fn.stdpath("config") .. "/data/jars/jol-cli-0.17-full.jar"
  local function with_compile(fn)
    return function()
      if vim.bo.modified then
        vim.cmd("w")
      end
      client.request_sync("java/buildWorkspace", false, 5000, bufnr)
      fn()
    end
  end
  local create_command = vim.api.nvim_buf_create_user_command
  create_command(bufnr, "JdtRunLast", with_compile(require("dap").run_last), { nargs = 0 })
  create_command(bufnr, "JdtTestClass", with_compile(jdtls.test_class), { nargs = 0 })
  create_command(bufnr, "JdtTestNearestMethod", with_compile(jdtls.test_nearest_method), { nargs = 0 })
  create_command(bufnr, "JdtPickTest", with_compile(jdtls.pick_test), { nargs = 0 })
  create_command(bufnr, "JdtExtractVariable", jdtls.extract_variable, { nargs = 0 })
  create_command(bufnr, "JdtExtractConstant", jdtls.extract_constant, { nargs = 0 })
  create_command(bufnr, "JdtExtractMethod", function()
    jdtls.extract_method(true)
  end, { nargs = 0 })

  create_command(bufnr, "JdtTestGenerate", require("jdtls.tests").generate, { nargs = 0 })
  create_command(bufnr, "JdtTestGoto", require("jdtls.tests").goto_subjects, { nargs = 0 })
  create_command(
    bufnr,
    "JdtRun",
    with_compile(function()
      local main_config_opts = {
        verbose = false,
        on_ready = require("dap")["continue"],
      }
      require("jdtls.dap").setup_dap_main_class_configs(main_config_opts)
    end),
    {
      nargs = 0,
    }
  )
end

local get_init_options = function()
  local opts = {
    bundles = {},
    extendedClientCapabilities = require("jdtls.capabilities"),
  }

  -- vscode-java-debug
  local java_debug_path = data_dir .. "/mason/packages/java-debug-adapter/extension/server"
  vim.list_extend(
    opts.bundles,
    vim.split(vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar"), "\n")
  )

  -- vscode-java-test
  local java_test_path = data_dir .. "/mason/packages/java-test/extension/server"
  for _, bundle in ipairs(vim.split(vim.fn.glob(java_test_path .. "/*.jar"), "\n")) do
    if
      not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
      and not vim.endswith(bundle, "jacocoagent.jar")
    then
      table.insert(opts.bundles, bundle)
    end
  end

  -- vscode-java-decompiler
  local java_decoompiler_path = data_dir .. "/mason/packages/vscode-java-decompiler/extension/server"
  vim.list_extend(opts.bundles, vim.split(vim.fn.glob(java_decoompiler_path .. "/*.jar"), "\n"))

  -- vscode-java-dependency
  local java_dependency_path = data_dir .. "/mason/packages/vscode-java-dependency/extension/server"
  vim.list_extend(opts.bundles, vim.split(vim.fn.glob(java_dependency_path .. "/*.jar"), "\n"))

  -- 添加 spring-boot jdtls 扩展 jar 包
  vim.list_extend(opts.bundles, require("spring_boot").java_extensions())

  return opts
end

local jdtls_cmd = function()
  return {
    utils.java_bin(),
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dosgi.checkConfiguration=true",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx4g",
    "-XX:+UseZGC",
    "--enable-native-access=ALL-UNNAMED",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. get_javaagent(),
    "-jar",
    get_launcher_files(),
    "-configuration",
    get_jdtls_cfg_dir(),
    "-data",
    get_workspace_dir(),
  }
end

local M = {}

M.spring_boot_opts = function()
  return {
    autocmd = true,
    java_cmd = utils.java_bin(),
  }
end

M.jdtls_config = function()
  return {
    cmd = jdtls_cmd(),
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),
    on_attach = on_attach,
    init_options = get_init_options(),
    settings = {
      java = {
        format = { settings = utils.fmt_config() },
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
        configuration = { runtimes = utils.get_sdkman_java_runtimes() },
        import = {
          gradle = { enabled = true },
          maven = { enabled = true },
          exclusions = {
            "**/node_modules/**",
            "**/.metadata/**",
            "**/archetype-resources/**",
            "**/META-INF/maven/**",
            "**/.git/**",
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
