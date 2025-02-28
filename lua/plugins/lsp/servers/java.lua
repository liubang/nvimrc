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
local java = require("java")
local lspconfig = require("lspconfig")

java.setup({
  root_markers = {
    "settings.gradle",
    "settings.gradle.kts",
    "pom.xml",
    "build.gradle",
    "mvnw",
    "gradlew",
    "build.gradle",
    "build.gradle.kts",
    ".git",
  },
  lombok = {
    version = "nightly",
  },
  spring_boot_tools = {
    enable = true,
  },
  java_debug_adapter = {
    enable = true,
  },
  java_test = {
    enable = true,
  },
  jdk = {
    auto_install = false,
  },
  notifications = {
    dap = false,
  },
  verification = {
    invalid_order = true,
  },
})

lspconfig.jdtls.setup(c.default({
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = os.getenv("JAVA_HOME"),
            default = true,
          },
        },
      },
    },
  },
}))
