return {
  {
    "nvim-treesitter/playground",
    build = ":TSInstall query",
    cmd = "TSPlaygroundToggle",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "p00f/nvim-ts-rainbow",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    -- event = "BufReadPost",
    build = ":TSUpdate",
    config = function()
      require "lb.cfg.treesitter"
    end,
  },
}
