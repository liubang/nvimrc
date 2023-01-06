--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/12/07 19:49
--
--=====================================================================

local lspconfig = require "lspconfig"
local c = require "plugins.lsp.customs"

for _, server in ipairs {
  "php",
  "vue",
  "jsonls",
  "yamlls",
  "clangd",
  "gopls",
  "rust",
  "sumneko_lua",
  "null-ls",
} do
  require("plugins.lsp.servers." .. server).setup()
end

-- some others use default config
for _, server in ipairs {
  "taplo", -- for toml
  "html",
  "cssls",
  "emmet_ls", -- emmet YYDS!
  "tsserver",
  "pyright",
  "bashls",
  "cmake",
  "texlab",
  "vimls",
} do
  lspconfig[server].setup(c.default())
end
