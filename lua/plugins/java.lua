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
local java_bin = os.getenv("SDKMAN_DIR") .. "/candidates/java/25.0.1-tem/bin/java"

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
      local os = uname.sysname

      local cfg_dir = "config"
      if os == "Linux" then
        cfg_dir = cfg_dir .. "_linux"
      elseif os == "Darwin" then
        cfg_dir = cfg_dir .. "_mac"
      end

      if uname.machine == "arm64" then
        cfg_dir = cfg_dir .. "_arm"
      end

      if #launcher_files == 0 then
        print("Launcher jar not found")
        return
      end

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
          }, --- }}}
        }, --- }}}
        on_attach = function(_, bufnr)
          local jdtls = require("jdtls")
          jdtls.jol_path = vim.fn.stdpath("config") .. "/data/jars/jol-cli-0.17-full.jar"
          local create_command = vim.api.nvim_buf_create_user_command
          create_command(bufnr, "JdtTestGenerate", require("jdtls.tests").generate, { nargs = 0 })
          create_command(bufnr, "JdtTestGoto", require("jdtls.tests").goto_subjects, { nargs = 0 })
        end,
        init_options = { --- init_options {{{
          bundles = {},
          extendedClientCapabilities = require("jdtls.capabilities"),
        }, --- }}}
      } --- }}}

      -- 添加 spring-boot jdtls 扩展 jar 包
      vim.list_extend(config.init_options.bundles, require("spring_boot").java_extensions())

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
