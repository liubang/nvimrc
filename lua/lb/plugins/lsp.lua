return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "SmiteshP/nvim-navic",
    config = function()
      require "lb.cfg.nvim-navic"
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require "lb.cfg.fidget"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "folke/neodev.nvim",
      "simrat39/rust-tools.nvim",
      "b0o/schemastore.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      -- It's important that you set up the plugins in the following order:
      -- 1. mason.nvim
      -- 2. mason-lspconfig.nvim
      -- Setup servers via lspconfig
      require "lb.cfg.mason"
      require "lb.cfg.lsp"
    end,
  },
}
