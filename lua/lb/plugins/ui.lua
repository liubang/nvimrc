return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      require "lb.cfg.theme"
    end,
  },
  {
    "goolord/alpha-nvim",
    lazy = false,
    config = function()
      require "lb.cfg.alpha"
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require "lb.cfg.notify"
    end,
    event = "VeryLazy",
  },
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    config = function()
      require "lb.cfg.bufferline"
    end,
    event = "BufAdd",
  },
  { "famiu/bufdelete.nvim", event = "BufAdd" },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "SmiteshP/nvim-navic",
    },
    config = function()
      require "lb.cfg.lualine"
    end,
    event = "VeryLazy",
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "lb.cfg.nvim-tree"
    end,
    cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFindFile" },
  },
}
