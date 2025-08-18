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

for _, server in ipairs({
  "clangd",
  "gopls",
  "basedpyright",
  "jsonls",
  "lua_ls",
  "yamlls",
  "texlab",
  "bzl",
}) do
  vim.lsp.config(server, require("plugins.lsp.servers." .. server))
  vim.lsp.enable(server)
end

vim.lsp.enable({
  "lemminx", -- for xml
  "thriftls", -- for thrift
  "taplo", -- for toml
  "bashls",
  "protols",
  "cmake",
  "ruff",
  "intelephense", -- for php
  "nginx_language_server",
})

-- vim: fdm=marker fdl=0
