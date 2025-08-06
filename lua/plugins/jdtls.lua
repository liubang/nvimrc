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

return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {
    "JavaHello/spring-boot.nvim",
  },
  config = function()
    local data_dir = vim.fn.stdpath("data")
    local java_bin = os.getenv("JAVA_HOME") .. "/bin/java"
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

    local config = {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
      cmd = {
        java_bin,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "-javaagent:" .. lombok_path,
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        launcher_files[1],
        "-configuration",
        data_dir .. "/mason/packages/jdtls/" .. cfg_dir,
        "-data",
        workspace_dir,
      },

      root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),

      settings = {
        java = {},
      },
      init_options = {},
      bundles = {},
    }
    -- 添加 spring-boot jdtls 扩展 jar 包
    vim.list_extend(config.bundles, require("spring_boot").java_extensions())
    local group = vim.api.nvim_create_augroup("JdtlsGroup", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "java",
      callback = function(_)
        require("jdtls").start_or_attach(config)
      end,
    })
  end,
}
