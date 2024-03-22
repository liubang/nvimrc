--=====================================================================
--
-- plugins.lua -
--
-- Created by liubang on 2023/12/09 22:41
-- Last Modified: 2023/12/09 22:41
--
--=====================================================================

require("lazy").setup({
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
  ui = {
    border = "single",
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },
  performance = { -- {{{
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "2html_plugin",
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "syntax",
        "vimball",
        "vimballPlugin",
      },
    },
  }, -- }}}
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = { -- {{{
    root = vim.fn.stdpath("state") .. "/lazy/readme",
    files = { "README.md" },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  }, -- }}}
  profiling = {
    loader = false,
    require = false,
  },
})
