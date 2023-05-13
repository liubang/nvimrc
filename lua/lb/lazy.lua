-- =====================================================================
--
-- lazy.lua -
--
-- Created by liubang on 2021/04/19 11:00
-- Last Modified: 2022/12/31 22:30
--
-- =====================================================================

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  spec = { import = "plugins" },
  defaults = { lazy = true },
  concurrency = 6,
  install = {
    missing = true,
    colorscheme = { "gruvbox-material" },
  },
  dev = {
    path = "~/workspace/vim",
    patterns = { "liubang" },
    fallback = true,
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
  },
  ui = { -- {{{
    border = "single",
    -- stylua: ignore
    icons = {
      loaded     = "●",
      not_loaded = "○",
      cmd        = " ",
      config     = " ",
      event      = "",
      ft         = " ",
      init       = " ",
      keys       = " ",
      plugin     = " ",
      runtime    = " ",
      source     = " ",
      start      = "",
      task       = " ",
      lazy       = "鈴 ",
    },
  }, -- }}}
  performance = { -- {{{
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  }, -- }}}
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = { -- {{{
    root = vim.fn.stdpath "state" .. "/lazy/readme",
    files = { "README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  }, -- }}}
}

-- vim: fdm=marker fdl=0
