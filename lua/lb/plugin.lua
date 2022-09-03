-- =====================================================================
--
-- plugins.lua -
--
-- Created by liubang on 2021/04/19 11:00
-- Last Modified: 2021/04/19 11:00
--
-- =====================================================================

local utils = require 'lb.utils.plugin'
local packer = require 'packer'

utils.bootstrap_packer()

packer.init {
  auto_clean = true,
  compile_on_sync = true,
  ensure_dependencies = true,
  display = {
    title = ' packer.nvim',
    non_interactive = false,
    header_lines = 2,
    working_sym = ' ',
    moved_sym = ' ',
    error_sym = '',
    done_sym = '',
    removed_sym = '',
    show_all_info = true,
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end,
  },
  git = {
    depth = 1,
    clone_timeout = 300,
  },
}

packer.startup(function(use)
  -- have packer manage itself
  use { 'wbthomason/packer.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'lewis6991/impatient.nvim' }

  -- performance
  use {
    'antoinemadec/FixCursorHold.nvim',
    run = function()
      vim.g.cursorhold_updatetime = 100
    end,
  }

  -- appearance
  use {
    'sainnhe/gruvbox-material',
    config = function()
      require 'lb.plugins.theme'
    end,
  }

  use {
    'kyazdani42/nvim-web-devicons',
    event = 'UIEnter',
  }

  use {
    'goolord/alpha-nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require 'lb.plugins.dashboard'
    end,
    event = 'BufWinEnter',
  }

  use {
    'rcarriga/nvim-notify',
    config = function()
      return 'lb.plugins.notify'
    end,
    event = 'UIEnter',
  }

  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = { 'famiu/bufdelete.nvim' },
    config = function()
      require 'lb.plugins.bufferline'
    end,
    event = { 'UIEnter' },
  }

  use {
    'SmiteshP/nvim-navic',
    config = function()
      require 'lb.plugins.nvim-navic'
    end,
    event = { 'UIEnter' },
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'j-hui/fidget.nvim',
      'kyazdani42/nvim-web-devicons',
      'SmiteshP/nvim-navic',
    },
    after = {
      'nvim-navic',
    },
    config = function()
      require 'lb.plugins.lualine'
    end,
  }

  use {
    'MunifTanjim/nui.nvim',
    config = function()
      require 'lb.plugins.nui'
    end,
    event = 'UIEnter',
  }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'kyazdani42/nvim-web-devicons',
      { 'MunifTanjim/nui.nvim' },
      { 's1n7ax/nvim-window-picker', tag = '1.*' },
    },
    config = function()
      require 'lb.plugins.neo-tree'
    end,
    cmd = { 'Neotree' },
  }

  -- tools
  use {
    'rainbowhxch/accelerated-jk.nvim',
    event = { 'BufEnter' },
  }

  use {
    'mrjones2014/smart-splits.nvim',
    config = function()
      require 'lb.plugins.smart-split'
    end,
    event = { 'BufReadPre', 'BufNewFile' },
  }

  use { 'willchao612/vim-diagon', cmd = 'Diagon' }
  use { 'jbyuki/venn.nvim', keys = { '<leader>v' } }

  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup {}
    end,
    event = { 'BufReadPre', 'BufNewFile' },
  }

  use {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require 'lb.plugins.fold'
    end,
    event = { 'BufNewFile', 'BufRead' },
  }

  use {
    'voldikss/vim-floaterm',
    config = function()
      vim.g.floaterm_wintype = 'float'
      vim.g.floaterm_position = 'bottom'
      vim.g.floaterm_autoinsert = true
      vim.g.floaterm_width = 0.999
      vim.g.floaterm_height = 0.7
      vim.g.floaterm_title = '─────  Floaterm [$1|$2] '
    end,
  }
  use {
    'skywind3000/asynctasks.vim',
    requires = {
      'skywind3000/asyncrun.vim',
      'skywind3000/asyncrun.extra',
    },
    config = function()
      vim.g.asyncrun_open = 25
      vim.g.asyncrun_bell = 1
      vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', 'build.xml' }
      vim.g.asynctasks_term_pos = 'floaterm'
      vim.g.asynctasks_term_reuse = 1
    end,
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require 'lb.plugins.git'
    end,
    event = { 'BufNewFile', 'BufRead' },
  }

  use {
    'itchyny/vim-cursorword',
    event = { 'BufReadPre', 'BufNewFile' },
  }

  use {
    'junegunn/vim-easy-align',
    keys = { 'ga' },
  }

  -- MixedCase/PascalCase:   gsm/gsp
  -- camelCase:              gsc
  -- snake_case:             gs_
  -- UPPER_CASE:             gsu/gsU
  -- Title Case:             gst
  -- Sentence case:          gss
  -- space case:             gs<space>
  -- dash-case/kebab-case:   gs-/gsk
  -- Title-Dash/Title-Kebab: gsK
  -- dot.case:               gs.
  use { 'arthurxavierx/vim-caser', keys = { 'gs' } }

  use {
    'sQVe/sort.nvim',
    config = function()
      require('sort').setup {
        delimiters = { ',', '|', ';', ':', 's', 't' },
      }
    end,
    cmd = { 'Sort' },
  }

  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        before = { 'telescope.nvim' },
      },
      {
        'nvim-telescope/telescope-ui-select.nvim',
        before = { 'telescope.nvim' },
      },
    },
    config = function()
      require 'lb.plugins.telescope'
    end,
  }

  use {
    'simrat39/symbols-outline.nvim',
    after = {
      'nvim-lspconfig',
    },
    config = function()
      require 'lb.plugins.outline'
    end,
    events = { 'BufNewFile', 'BufRead' },
    cmd = { 'SymbolsOutline' },
  }

  use {
    'numToStr/Comment.nvim',
    after = { 'nvim-treesitter' },
    config = function()
      require 'lb.plugins.comment'
    end,
    events = { 'InsertEnter' },
  }

  use { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
      { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
    },
    run = ':TSUpdate',
    cmd = 'TSUpdate',
    event = { 'BufRead', 'BufNewFile', 'InsertEnter' },
  }

  -- lsp
  use {
    'folke/lua-dev.nvim',
    event = { 'BufRead', 'BufNewFile', 'InsertEnter' },
  }

  use {
    'simrat39/rust-tools.nvim',
    event = { 'BufRead', 'BufNewFile', 'InsertEnter' },
  }

  use {
    'williamboman/mason.nvim',
    requires = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require 'lb.plugins.installer'
    end,
    event = { 'BufRead', 'BufNewFile', 'InsertEnter' },
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'simrat39/rust-tools.nvim',
      'folke/lua-dev.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
    },
    after = {
      'mason.nvim',
      'rust-tools.nvim',
      'lua-dev.nvim',
      'null-ls.nvim',
      'nvim-cmp',
      'cmp-nvim-lsp',
    },
    config = function()
      require 'lb.lsp'
    end,
  }

  use {
    'j-hui/fidget.nvim',
    config = function()
      require 'lb.plugins.fidget'
    end,
    after = { 'nvim-lspconfig' },
    event = { 'BufRead', 'BufNewFile' },
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    event = { 'BufRead', 'BufNewFile' },
  }

  -- completion
  use {
    'L3MON4D3/LuaSnip',
    requires = {
      'Comment.nvim',
      'nvim-treesitter',
    },
    after = { 'Comment.nvim', 'nvim-treesitter' },
    config = function()
      require 'lb.plugins.snip'
    end,
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-calc', after = 'nvim-cmp' },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    },
    after = { 'LuaSnip', 'nvim-treesitter' },
    config = function()
      require 'lb.plugins.cmp'
    end,
  }

  use {
    'windwp/nvim-autopairs',
    requires = {
      'hrsh7th/nvim-cmp',
      'nvim-treesitter/nvim-treesitter',
    },
    after = { 'nvim-cmp', 'nvim-treesitter' },
    config = function()
      require 'lb.plugins.autopairs'
    end,
  }

  -- ft
  use { 'cespare/vim-toml', ft = { 'toml' } }
  use {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    run = function()
      vim.fn['mkdp#util#install']()
    end,
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
  }
end)
