return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
      { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
      {
        "nvim-treesitter/playground",
        build = ":TSInstall query",
      },
    },
    config = function()
      require "lb.cfg.treesitter"
    end,
    build = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
  },
}
