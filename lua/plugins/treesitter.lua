--=====================================================================
--
-- treesitter.lua -
--
-- Created by liubang on 2023/11/26 15:42
-- Last Modified: 2023/11/26 15:42
--
--=====================================================================

local config = require("lb.config")

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
      "json",
      "jsonc",
    },
    fold = { enable = true },
    indent = { enable = false },
    matchup = { enable = true },
    highlight = {
      enable = true,
      disable = function(ft, bufnr)
        if vim.tbl_contains({ "vim" }, ft) then
          return true
        end

        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
        if ok and stats and stats.size < config.ts.treesitter_highlight_max_filesize then
          return false
        end
        return vim.api.nvim_buf_line_count(bufnr or 0) > config.ts.treesitter_highlight_maxlines
      end,
      additional_vim_regex_highlighting = false,
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_option_value("foldmethod", "expr", {})
    vim.api.nvim_set_option_value("foldexpr", "nvim_treesitter#foldexpr()", {})
    require("nvim-treesitter.configs").setup(opts)
  end,
}
