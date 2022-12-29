return {
  { "nvim-tree/nvim-web-devicons" },
  {
    "sainnhe/gruvbox-material",
    config = function()
      require "lb.cfg.theme"
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require "lb.cfg.alpha"
    end,
    event = { "BufWinEnter" },
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require "lb.cfg.notify"
    end,
    event = { "UIEnter" },
  },
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    config = function()
      require "lb.cfg.bufferline"
    end,
    event = { "UIEnter" },
  },
  { "famiu/bufdelete.nvim", event = { "BufWinEnter" } },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "SmiteshP/nvim-navic",
    },
    config = function()
      require "lb.cfg.lualine"
    end,
    event = { "UIEnter" },
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
