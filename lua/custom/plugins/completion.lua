return {
  "onsails/lspkind.nvim",

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-calc",
      "saadparwaiz1/cmp_luasnip",
      "kdheepak/cmp-latex-symbols",
    },
    event = "InsertEnter",
    config = function()
      require "lb.cfg.cmp"
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
      require "lb.cfg.luasnip"
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require "lb.cfg.autopairs"
    end,
  },

  {
    "saecki/crates.nvim",
    event = "InsertEnter",
    config = function()
      require "lb.cfg.crates-nvim"
    end,
  },

  {
    "gelguy/wilder.nvim",
    dependencies = {
      "romgrk/fzy-lua-native",
      build = "make",
    },
    config = function()
      require "lb.cfg.wilder"
    end,
  },
}
