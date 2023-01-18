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
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdateSync",
    event = "BufReadPost",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = {
        "c",
        "go",
        "cpp",
        "lua",
        "rust",
        "python",
        "cmake",
        "gomod",
        "json",
        "latex",
        "css",
        "html",
        "yaml",
        "toml",
        "vim",
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
      textobjects = { -- {{{
        lsp_interop = { enable = false },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]]"] = "@function.outer",
            ["]m"] = "@class.outer",
          },
          goto_next_end = {
            ["]["] = "@function.outer",
            ["]M"] = "@class.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            ["[m"] = "@class.outer",
          },
          goto_previous_end = {
            ["[]"] = "@function.outer",
            ["[M"] = "@class.outer",
          },
        },
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      }, -- }}}

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
