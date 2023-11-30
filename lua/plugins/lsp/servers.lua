--=====================================================================
--
-- servers.lua -
--
-- Created by liubang on 2023/05/12 14:51
-- Last Modified: 2023/05/12 14:51
--
--=====================================================================
local c = require("plugins.lsp.customs")
local lspconfig = require("lspconfig")

for _, server in ipairs({
  "cpp",
  "golang",
  "rust",
  "python",
  "lua",
  "json",
  "yaml",
  "latex",
}) do
  require("plugins.lsp.servers." .. server)
end

for _, server in ipairs({
  -- "html",
  -- "cssls",
  -- "emmet_ls", -- emmet YYDS!
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
