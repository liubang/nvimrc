-- =====================================================================
--
-- lazy.lua -
--
-- Created by liubang on 2021/04/19 11:00
-- Last Modified: 2022/12/30 00:20
--
-- =====================================================================

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("lb.plugins", {
  defaults = { lazy = true },
  install = { colorscheme = { "gruvbox-material" } },
  ui = {
    border = "single",
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "nvim-treesitter-textobjects",
      },
    },
  },
})
