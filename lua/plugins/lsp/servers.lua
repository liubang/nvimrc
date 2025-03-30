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
local lspconfig = require("lspconfig")

for _, server in ipairs({
  "cpp",
  "golang",
  "java",
  "python",
  "lua",
  "json",
  "yaml",
  "latex",
  "bzl",
}) do
  require("plugins.lsp.servers." .. server)
end

for _, server in ipairs({
  "lemminx",
  "thriftls",
  "taplo", -- for toml
  "bashls",
  "cmake",
  "intelephense",
  "nginx_language_server",
}) do
  lspconfig[server].setup(c.default())
end

-- vim: fdm=marker fdl=0
