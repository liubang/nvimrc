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
  install = { missing = true, colorscheme = { "gruvbox-material" } },
  git = {
    log = { "-5" }, -- show the last 10 commits
  },
  dev = {
    -- directory where you store your local plugin projects
    path = "~/workspace/vim",
    ---@type string[] plugins that match these patterns will use your local versions
    -- instead of being fetched from GitHub
    patterns = {},
  },
  ui = {
    border = "single",
    icons = {
      loaded = "●",
      not_loaded = "○",
      cmd = " ",
      config = " ",
      event = "",
      ft = " ",
      init = " ",
      keys = " ",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = " ",
      lazy = "鈴 ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
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
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    root = vim.fn.stdpath "state" .. "/lazy/readme",
    files = { "README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
})
