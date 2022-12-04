--=====================================================================
--
-- treesitter.lua -
--
-- Created by liubang on 2022/03/02 16:58
-- Last Modified: 2022/12/05 00:57
--
--=====================================================================

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "rust",
    "go",
    "gomod",
    "json",
    "html",
    "yaml",
    "python",
    "latex",
    "css",
    "javascript",
    "typescript",
  },
  sync_install = false,
  ignore_install = { "haskell" },
  highlight = {
    enable = true,
    use_languagetree = false,
    custom_captures = {
      ["function.call"] = "TSFunction",
      ["function.bracket"] = "Type",
      ["namespace.type"] = "Namespace",
    },
  },
  fold = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<Leader>v",
      node_incremental = "v",
      node_decremental = "V",
    },
  },
  indent = { enable = true },
  autopairs = { enable = true },
  matchup = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  textobjects = {
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
  },

  autotag = {
    enable = true,
    filetypes = { "html", "xml", "javascript", "typescript", "markdown" },
  },

  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
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
}
