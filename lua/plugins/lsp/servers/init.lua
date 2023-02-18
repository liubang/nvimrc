--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/12/07 19:49
--
--=====================================================================

for _, server in ipairs {
  "php",
  "vue",
  "jsonls",
  "yamlls",
  "clangd",
  "gopls",
  "rust",
  "lua_ls",
  "tsserver",
  "null-ls",
  "jdtls",
} do
  require("plugins.lsp.servers." .. server).setup()
end

-- some others use default config
local lspconfig = require "lspconfig"
local c = require "plugins.lsp.customs"

for _, server in ipairs {
  "taplo", -- for toml
  "html",
  "cssls",
  "emmet_ls", -- emmet YYDS!
  "pyright",
  "bashls",
  "cmake",
  "texlab",
  "vimls",
  "lemminx", -- for xml
} do
  lspconfig[server].setup(c.default())
end
