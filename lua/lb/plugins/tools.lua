return {
  {
    "numToStr/Comment.nvim",
    event = "InsertEnter",
    config = function()
      require "lb.cfg.comment"
    end,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    lazy = false,
    config = function()
      require "lb.cfg.accelerated-jk"
    end,
  },
  {
    "gbprod/yanky.nvim",
    event = "BufReadPost",
    dependencies = {
      "kkharji/sqlite.lua",
    },
    config = function()
      require("yanky").setup {
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = true,
          on_yank = true,
          timer = 300,
        },
        preserve_cursor_position = {
          enabled = true,
        },
        ring = {
          storage = jit.os:find "Windows" and "shada" or "sqlite",
        },
      }
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      require "lb.cfg.smartsplit"
    end,
    event = { "BufReadPost" },
  },
  {
    "jbyuki/venn.nvim",
    config = function()
      require "lb.cfg.venn"
    end,
  },
  -- https://github.com/ArthurSonzogni/Diagon
  {
    "willchao612/vim-diagon",
    cmd = { "Diagon" },
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup {}
    end,
    event = { "BufReadPost" },
  },
  {
    "voldikss/vim-floaterm",
    config = function()
      require "lb.cfg.floaterm"
    end,
    cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
  },
  {
    "skywind3000/asynctasks.vim",
    dependencies = {
      { "skywind3000/asyncrun.vim" },
      { "skywind3000/asyncrun.extra" },
      { "voldikss/vim-floaterm" },
    },
    config = function()
      require "lb.cfg.asynctasks"
    end,
    cmd = { "AsyncTask", "AsyncRun" },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require "lb.cfg.git"
    end,
    event = "BufReadPre",
  },
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-git" },
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      require "lb.cfg.mini-nvim"
    end,
    event = "VeryLazy",
  },
  -- MixedCase/PascalCase:   gsm/gsp
  -- camelCase:              gsc
  -- snake_case:             gs_
  -- UPPER_CASE:             gsu/gsU
  -- Title Case:             gst
  -- Sentence case:          gss
  -- space case:             gs<space>
  -- dash-case/kebab-case:   gs-/gsk
  -- Title-Dash/Title-Kebab: gsK
  -- dot.case:               gs.
  { "arthurxavierx/vim-caser" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      require "lb.cfg.telescope"
    end,
    cmd = "Telescope",
    event = "VeryLazy",
  },

  {
    "stevearc/aerial.nvim",
    config = function()
      require "lb.cfg.aerial"
    end,
    cmd = "AerialToggle",
  },

  {
    "mbbill/undotree",
    branch = "search",
    config = function()
      require "lb.cfg.undotree"
    end,
    cmd = { "UndotreeShow", "UndotreeToggle" },
  },

  { "dstein64/vim-startuptime", cmd = "StartupTime" },
}
