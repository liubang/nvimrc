--=====================================================================
--
-- treesitter.lua -
--
-- Created by liubang on 2023/11/26 15:42
-- Last Modified: 2023/11/26 15:42
--
--=====================================================================

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  cmd = {
    "TSBufDisable",
    "TSBufEnable",
    "TSBufToggle",
    "TSDisable",
    "TSEnable",
    "TSToggle",
    "TSInstall",
    "TSInstallInfo",
    "TSInstallSync",
    "TSModuleInfo",
    "TSUninstall",
    "TSUpdate",
    "TSUpdateSync",
  },
  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "rust",
      "lua",
      "go",
      "python",
      "proto",
      "gomod",
      "gosum",
      "gowork",
      "sql",
      "markdown",
      "markdown_inline",
      "vimdoc",
      "json",
    },
    fold = { enable = true },
    indent = { enable = false },
    matchup = { enable = true },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_option_value("foldmethod", "expr", {})
    vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})
    require("nvim-treesitter.configs").setup(opts)
  end,
}
