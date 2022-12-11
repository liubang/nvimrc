--=====================================================================
--
-- sumneko_lua.lua -
--
-- Created by liubang on 2022/08/06 00:26
-- Last Modified: 2022/12/07 22:35
--
--=====================================================================

vim.cmd.packadd "neodev.nvim"

local neodev = require "neodev"
local lspconfig = require "lspconfig"
local c = require "lb.cfg.lsp.customs"

neodev.setup {
  library = {
    enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
    -- these settings will be used for your Neovim config directory
    runtime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  setup_jsonls = false, -- configures jsonls to provide completion for project specific .luarc.json files
  -- With lspconfig, Neodev will automatically setup your lua-language-server
  -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
  -- in your lsp start options
  lspconfig = true,
}

local setup = function()
  lspconfig.sumneko_lua.setup(c.default {
    settings = {
      Lua = {
        format = {
          enable = false,
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end

return {
  setup = setup,
}
