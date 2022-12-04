--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/10/16 15:50
--
--=====================================================================

local lspconfig = require "lspconfig"
local c = require "lb.cfg.lsp.customs"

for _, server in ipairs {
  "php",
  "jsonls",
  "yamlls",
  "clangd",
  "gopls",
  "rust",
  "sumneko_lua",
  "null-ls",
} do
  require("lb.cfg.lsp.servers." .. server).setup()
end

-- some others use default config
for _, server in ipairs {
  "html",
  "cssls",
  "tsserver",
  "pyright",
  "eslint",
  "bashls",
  "cmake",
  "texlab",
  "vimls",
} do
  lspconfig[server].setup(c.default())
end
