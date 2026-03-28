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

local defaults = require("plugins.lsp.defaults")

for _, server in ipairs({
  "clangd",
  "gopls",
  "basedpyright",
  "jsonls",
  "lua_ls",
  "yamlls",
  "texlab",
  "lemminx", -- for xml
}) do
  defaults.enable(server, require("plugins.lsp.servers." .. server))
end

for _, server in ipairs({
  "thriftls", -- for thrift
  "taplo", -- for toml
  "ts_ls",
  "bashls",
  "protols",
  "neocmake",
  "intelephense", -- for php
  "nginx_language_server",
  "docker_language_server",
}) do
  defaults.enable(server)
end

-- vim: fdm=marker fdl=0
