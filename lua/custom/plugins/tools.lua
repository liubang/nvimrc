return {
  {
    "rainbowhxch/accelerated-jk.nvim",
    config = function()
      require "lb.cfg.accelerated-jk"
    end,
  },
  {
    "ibhagwan/smartyank.nvim",
    config = function()
      require "lb.cfg.smartyank"
    end,
    event = { "BufReadPost" },
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
    event = { "BufReadPost", "BufNewFile" },
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
    event = { "BufReadPost", "BufNewFile" },
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
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = [[
                  cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release \
                     && cmake --build build --config Release \
                     && cmake --install build --prefix build
                ]],
      },
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
    cmd = { "AerialToggle" },
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
