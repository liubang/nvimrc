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
  config = function()
    local data_dir = vim.fn.stdpath("data")
    local java_bin = os.getenv("JAVA_HOME") .. "/bin/java"
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name
    local lombok_path = data_dir .. "/mason/packages/lombok-nightly/lombok.jar"
    local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
    local config = {
      capabilities = blink_capabilities,
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
        data_dir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar",
        "-configuration",
        data_dir .. "/mason/packages/jdtls/config_linux",
        "-data",
        workspace_dir,
      },

      root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" }),

      settings = {
        java = {},
      },
      init_options = {},
    }
    require("jdtls").start_or_attach(config)
  end,
}
