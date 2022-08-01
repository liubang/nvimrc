--=====================================================================
--
-- treesitter.lua -
--
-- Created by liubang on 2022/03/02 16:58
-- Last Modified: 2022/03/02 16:58
--
--=====================================================================
require('nvim-treesitter.install').prefer_git = true

require('nvim-treesitter.configs').setup {
  ensure_installed = {}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { 'haskell' }, -- list of parsers to ignore installing
  highlight = {
    enable = true,
    disable = { 'html', 'json' }, -- list of language that will be disabled
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'v',
      node_incremental = 'v',
      node_decremental = 'V',
    },
  },

  indent = {
    enable = false,
  },

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
        [']]'] = '@function.outer',
        [']m'] = '@class.outer',
      },
      goto_next_end = {
        [']['] = '@function.outer',
        [']M'] = '@class.outer',
      },
      goto_previous_start = {
        ['[['] = '@function.outer',
        ['[m'] = '@class.outer',
      },
      goto_previous_end = {
        ['[]'] = '@function.outer',
        ['[M'] = '@class.outer',
      },
    },
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
  },

  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
}
