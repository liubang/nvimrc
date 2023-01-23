--=====================================================================
--
-- treesitter.lua -
--
-- Created by liubang on 2022/12/30 20:50
-- Last Modified: 2022/12/30 20:50
--
--=====================================================================

return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  -- { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdateSync",
    event = "BufReadPost",
    keys = {
      { "<Leader>v", desc = "Increment selection", mode = "n" },
      { "V", desc = "Schrink selection", mode = "x" },
    },
    opts = {
      ensure_installed = {
        "c",
        "go",
        "cpp",
        "lua",
        "vim",
        "rust",
        "regex",
        "python",
        "cmake",
        "gomod",
        "json",
        "json5",
        "jsonc",
        "latex",
        "css",
        "html",
        "yaml",
        "toml",
        "vue",
        "tsx",
        "javascript",
        "typescript",
        "markdown",
        "markdown_inline",
      },
      sync_install = false,
      highlight = { enable = true },
      fold = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      matchup = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Leader>v",
          node_incremental = "v",
          node_decremental = "V",
        },
      },
      playground = { --{{{
        enable = true,
        updatetime = 25,
        persist_queries = true,
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      }, --}}}
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.markdown.filetype_to_parsername = "octo"
    end,
  },
}

-- vim: fdm=marker fdl=0
