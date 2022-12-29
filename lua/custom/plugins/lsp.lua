return {
  "folke/neodev.nvim",
  "simrat39/rust-tools.nvim",
  "b0o/schemastore.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- It's important that you set up the plugins in the following order:
      -- 1. mason.nvim
      -- 2. mason-lspconfig.nvim
      -- Setup servers via lspconfig
      require "lb.cfg.mason"
      require "lb.cfg.lsp"
    end,
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require "lb.cfg.fidget"
    end,
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      require "lb.cfg.nvim-navic"
    end,
  },
}
