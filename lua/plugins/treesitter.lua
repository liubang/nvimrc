--=====================================================================
--
-- treesitter.lua -
--
-- Created by liubang on 2022/12/30 20:50
-- Last Modified: 2023/02/09 00:43
--
--=====================================================================

return {
  { 'JoosepAlviste/nvim-ts-context-commentstring' },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<Leader>v', desc = 'Increment selection', mode = 'n' },
      { 'V',         desc = 'Schrink selection',   mode = 'x' },
    },
    ---@type TSConfig
    opts = {
      ensure_installed = {
        'c',
        'cpp',
        'rust',
        'go',
        'gomod',
        'python',
        'latex',
        'lua',
        'bash',
        'yaml',
        'toml',
        'json',
        'tsx',
        'javascript',
        'typescript',
        'markdown',
        'markdown_inline',
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
          init_selection = '<Leader>v',
          node_incremental = 'v',
          node_decremental = 'V',
        },
      },
      playground = { --{{{
        enable = true,
        updatetime = 25,
        persist_queries = true,
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      }, --}}}
    },
    ---@param opts TSConfig
    -- stylua: ignore
    config = function(_, opts) require('nvim-treesitter.configs').setup(opts) end,
  },
}

-- vim: fdm=marker fdl=0
