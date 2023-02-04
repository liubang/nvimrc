-- =====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/02/06 00:10
-- Last Modified: 2023/01/25 01:49
--
-- =====================================================================

return {
  {
    "folke/neodev.nvim",
    opts = {
      experimental = { pathStrict = true },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "neodev.nvim",
      "simrat39/rust-tools.nvim",
      "b0o/schemastore.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "jose-elias-alvarez/typescript.nvim",
    },
    config = function()
      -- It's important that you set up the plugins in the following order:
      -- 1. mason.nvim
      -- 2. mason-lspconfig.nvim
      -- Setup servers via lspconfig
      -- require "lb.cfg.mason"
      require "plugins.lsp.handlers"
      require "plugins.lsp.servers"
      require "plugins.lsp.autocmd"
    end,
  },
}

-- vim: fdm=marker fdl=0
