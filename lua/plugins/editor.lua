--=====================================================================
--
-- editor.lua -
--
-- Created by liubang on 2023/05/12 14:16
-- Last Modified: 2023/05/12 14:16
--
--=====================================================================

return {
  {
    'andymass/vim-matchup', -- {{{
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
      vim.g.matchup_matchparen_deferred = 1
    end,
    -- }}}
  },
  {
    'RRethy/vim-illuminate', -- {{{
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      delay = 200,
      under_cursor = true,
      large_file_cutoff = 2000,
      large_file_overrides = { providers = { 'lsp' } },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set('n', key, function()
          require('illuminate')['goto_' .. dir .. '_reference'](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
      end

      map(']]', 'next')
      map('[[', 'prev')

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map(']]', 'next', buffer)
          map('[[', 'prev', buffer)
        end,
      })
    end,
    keys = {
      { ']]', desc = 'Next Reference' },
      { '[[', desc = 'Prev Reference' },
    },
    -- }}}
  },
  {
    'danymat/neogen', -- {{{
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {
      snippet_engine = 'luasnip',
    },
    cmd = { 'Neogen' },
    keys = {
      {
        '<Leader>nf',
        '<CMD>Neogen<CR>',
        mode = { 'n' },
        desc =
        "Generate annotation for the function, class or other relevant type you're currently in",
      },
    },
    -- }}}
  },
  {
    'rainbowhxch/accelerated-jk.nvim', -- {{{
    keys = {
      { 'j', '<Plug>(accelerated_jk_gj)', mode = { 'n' }, desc = 'Accelerated gj movement' },
      { 'k', '<Plug>(accelerated_jk_gk)', mode = { 'n' }, desc = 'Accelerated gk movement' },
    },
    opts = {
      mode = 'time_driven',
      enable_deceleration = false,
      acceleration_motions = {},
      acceleration_limit = 150,
      acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
      deceleration_table = { { 150, 9999 } },
    },
    -- }}}
  },
  {
    'phaazon/hop.nvim', -- {{{
    branch = 'v2',
    config = true,
    keys = {
      {
        '<Leader>kk',
        function()
          require('hop').hint_lines()
        end,
        mode = { 'n' },
        desc =
        'Hint the beginning of each lines currently visible in the buffer view and allow to jump to them',
      },
      {
        '<Leader>jj',
        function()
          require('hop').hint_lines()
        end,
        mode = { 'n' },
        desc =
        'Hint the beginning of each lines currently visible in the buffer view and allow to jump to them',
      },
      {
        '<Leader>ss',
        function()
          require('hop').hint_patterns()
        end,
        mode = { 'n' },
        desc = 'Annotate all matched patterns in the current window with key sequences',
      },
      {
        '<Leader>ll',
        function()
          require('hop').hint_words {
            direction = require('hop.hint').HintDirection.AFTER_CURSOR,
            -- current_line_only = true,
          }
        end,
        mode = { 'n' },
        desc = 'Annotate all words in the current line with key sequences',
      },
      {
        '<Leader>hh',
        function()
          require('hop').hint_words {
            direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
            -- current_line_only = true,
          }
        end,
        mode = { 'n' },
        desc = 'Annotate all words in the current line with key sequences',
      },
    },
    -- }}}
  },
  {
    'numToStr/Comment.nvim', -- {{{
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    keys = {
      { 'gc',  mode = { 'n', 'x' }, desc = 'Toggle line comment' },
      { 'gb',  mode = { 'n', 'x' }, desc = 'Toggle block comment' },
      { 'gcc', mode = 'n',          desc = 'Toggle line comment' },
      { 'gcb', mode = 'n',          desc = 'Toggle block comment' },
    },
    opts = function()
      -- set rust comment string
      local ft = require 'Comment.ft'
      ft.set('rust', '///%s')

      return {
        padding = true,
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
        mappings = {
          ---operator-pending mapping
          ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
          ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
          basic = true,
          ---extra mapping
          ---Includes `gco`, `gcO`, `gcA`
          extra = false,
        },
      }
    end,
    -- }}}
  },
  {
    'iamcco/markdown-preview.nvim', -- {{{
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    keys = {
      {
        '<Leader>mp',
        '<CMD>MarkdownPreview<CR>',
        desc = 'Markdown Preview',
      },
    },
    -- }}}
  },
  {
    'saecki/crates.nvim', -- {{{
    event = { 'BufReadPre Cargo.toml' },
    opts = {
      popup = {
        autofocus = true,
      },
    },
    -- }}}
  },
  {
    'RaafatTurki/hex.nvim', -- {{{
    config = true,
    cmd = { 'HexToggle' },
    -- }}}
  },
  {
    'lukas-reineke/headlines.nvim', -- {{{
    ft = { 'markdown', 'org' },
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {},
    -- }}}
  },
  {
    'LunarVim/bigfile.nvim', -- {{{
    lazy = false,
    opts = {
      filesize = 2,
      pattern = { '*' },
      features = {
        'indent_blankline',
        'illuminate',
        'lsp',
        'treesitter',
        'syntax',
        'matchparen',
        'vimopts',
        'filetype',
      },
    },
    -- }}}
  },
}

-- vim: fdm=marker fdl=0
