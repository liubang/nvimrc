-- Copyright (c) 2025 The Authors. All rights reserved.
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
local data_dir = vim.fn.stdpath("data")
local sdkman_dir = os.getenv("SDKMAN_DIR")
local java_bin = sdkman_dir .. "/candidates/java/25.0.1-tem/bin/java"

local function fmt_config()
  local fmt_path = vim.uv.cwd() .. "/eclipse-formatter.xml"
  local has_fmt = vim.uv.fs_stat(fmt_path)
  if has_fmt then
    return {
      url = fmt_path,
      profile = "Eclipse",
    }
  end
  return {}
end

local function get_sdkman_java_runtimes()
  local runtimes = {}
  local sdkman_java_path = vim.fn.expand(sdkman_dir .. "/candidates/java")

  if vim.fn.isdirectory(sdkman_java_path) == 0 then
    return runtimes
  end

  -- Java SE 版本命名映射
  local java_se_names = {
    ["1"] = "JavaSE-1.1",
    ["2"] = "JavaSE-1.2",
    ["3"] = "JavaSE-1.3",
    ["4"] = "JavaSE-1.4",
    ["5"] = "JavaSE-1.5",
    ["6"] = "JavaSE-1.6",
    ["7"] = "JavaSE-1.7",
    ["8"] = "JavaSE-1.8",
  }

  local function get_java_se_name(major_version)
    local version = tonumber(major_version)
    if java_se_names[major_version] then
      return java_se_names[major_version]
    else
      return "JavaSE-" .. major_version
    end
  end

  local handle = vim.loop.fs_scandir(sdkman_java_path)
  if not handle then
    return runtimes
  end

  local seen_paths = {}

  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end

    if (type == "directory" or type == "link") and name ~= "current" then
      local full_path = sdkman_java_path .. "/" .. name
      local real_path = vim.fn.resolve(full_path)

      if not seen_paths[real_path] and vim.fn.executable(full_path .. "/bin/java") == 1 then
        seen_paths[real_path] = true

        -- 提取主版本号
        local major_version = name:match("^(%d+)%.") or name:match("^(%d+)%-") or name:match("^(%d+)$")

        if major_version then
          table.insert(runtimes, {
            name = get_java_se_name(major_version),
            path = full_path,
            version_string = name,
          })
        end
      end
    end
  end

  -- 标记默认版本
  local current_path = sdkman_java_path .. "/current"
  if vim.fn.isdirectory(current_path) == 1 then
    local current_real = vim.fn.resolve(current_path)
    for _, runtime in ipairs(runtimes) do
      if vim.fn.resolve(runtime.path) == current_real then
        runtime.default = true
        break
      end
    end
  end

  -- 选择默认版本
  if #runtimes > 0 then
    local has_default = false
    for _, runtime in ipairs(runtimes) do
      if runtime.default then
        has_default = true
        break
      end
    end

    if not has_default then
      -- 按实际版本号排序
      table.sort(runtimes, function(a, b)
        -- 提取纯数字版本号用于比较
        local get_numeric_version = function(name)
          local v1 = name:match("JavaSE%-1%.(%d+)")
          if v1 then
            return tonumber(v1)
          end
          local v2 = name:match("JavaSE%-(%d+)")
          if v2 then
            return tonumber(v2)
          end
          return 0
        end
        return get_numeric_version(a.name) > get_numeric_version(b.name)
      end)
      runtimes[1].default = true
    end
  end

  return runtimes
end

return {
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "yaml", "jproperties" },
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      autocmd = true,
      java_cmd = java_bin,
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java", "yaml", "jproperties" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name
      local lombok_path = data_dir .. "/mason/packages/lombok-nightly/lombok.jar"
      local launcher_files =
        vim.fn.glob(data_dir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", true, true)

      local uv = vim.uv
      local uname = uv.os_uname()

      local cfg_dir = "config"
      if uname.sysname == "Linux" then
        cfg_dir = cfg_dir .. "_linux"
      elseif uname.sysname == "Darwin" then
        cfg_dir = cfg_dir .. "_mac"
      end

      if uname.machine == "arm64" then
        cfg_dir = cfg_dir .. "_arm"
      end

      if #launcher_files == 0 then
        print("Launcher jar not found")
        return
      end

      local config = {
        cmd = { --- {{{
          java_bin,
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
          "-javaagent:" .. lombok_path,
          "-jar",
          launcher_files[1],
          "-configuration",
          data_dir .. "/mason/packages/jdtls/" .. cfg_dir,
          "-data",
          workspace_dir,
        }, --- }}}
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),
        settings = { --- {{{
          java = { --- java {{{
            format = { settings = fmt_config() },
            autobuild = { enabled = false },
            maxConcurrentBuilds = 8,
            project = { encoding = "UTF-8" },
            foldingRange = { enabled = true },
            selectionRange = { enabled = true },
            import = { --- {{{
              gradle = { enabled = true },
              maven = { enabled = true },
              exclusions = {
                "**/node_modules/**",
                "**/.metadata/**",
                "**/archetype-resources/**",
                "**/META-INF/maven/**",
                "**/.git/**",
              },
            }, --- }}}
            inlayhints = { parameterNames = { enabled = "ALL" } },
            referenceCodeLens = { enabled = true },
            implementationsCodeLens = { enabled = true },
            templates = { --- {{{
              typeComment = {
                "/**",
                " * ${type_name}.",
                " *",
                " * @author ${user}",
                " */",
              },
            }, --- }}}
            eclipse = { downloadSources = true },
            maven = { downloadSources = true, updateSnapshots = true },
            signatureHelp = {
              enabled = true,
              description = { enabled = true },
            },
            contentProvider = { preferred = "fernflower" },
            completion = { --- {{{
              favoriteStaticMembers = { --- {{{
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
              }, --- }}}
              filteredTypes = { --- {{{
                "com.sun.*",
                "io.micrometer.shaded.*",
                "java.awt.*",
                "org.graalvm.*",
                "jdk.*",
                "sun.*",
              }, --- }}}
              importOrder = { --- {{{
                "java",
                "javax",
                "org",
                "com",
              }, --- }}}
            }, --- }}}
            sources = { --- {{{
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            }, --- }}}
            saveActions = { organizeImports = true },
            configuration = {
              runtimes = get_sdkman_java_runtimes(),
            },
          }, --- }}}
        }, --- }}}
        on_attach = function(client, bufnr)
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
        end,
        init_options = { --- init_options {{{
          bundles = {},
          extendedClientCapabilities = require("jdtls.capabilities"),
        }, --- }}}
      } --- }}}

      -- vscode-java-debug
      local java_debug_path = data_dir .. "/mason/packages/java-debug-adapter/extension/server"
      vim.list_extend(
        config.init_options.bundles,
        vim.split(vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar"), "\n")
      )

      -- vscode-java-test
      local java_test_path = data_dir .. "/mason/packages/java-test/extension/server"
      for _, bundle in ipairs(vim.split(vim.fn.glob(java_test_path .. "/*.jar"), "\n")) do
        if
          not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
          and not vim.endswith(bundle, "jacocoagent.jar")
        then
          table.insert(config.init_options.bundles, bundle)
        end
      end

      -- vscode-java-decompiler
      local java_decoompiler_path = data_dir .. "/mason/packages/vscode-java-decompiler/extension/server"
      vim.list_extend(config.init_options.bundles, vim.split(vim.fn.glob(java_decoompiler_path .. "/*.jar"), "\n"))

      -- vscode-java-dependency
      local java_dependency_path = data_dir .. "/mason/packages/vscode-java-dependency/extension/server"
      vim.list_extend(config.init_options.bundles, vim.split(vim.fn.glob(java_dependency_path .. "/*.jar"), "\n"))

      -- 添加 spring-boot jdtls 扩展 jar 包
      vim.list_extend(config.init_options.bundles, require("spring_boot").java_extensions())

      local group = vim.api.nvim_create_augroup("JdtlsGroup", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = { "java", "yaml", "jproperties" },
        callback = function(_)
          require("jdtls").start_or_attach(config)
        end,
      })
    end,
  },
}

-- vim: fdm=marker fdl=0
