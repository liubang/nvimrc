-- =====================================================================
--
-- plugins.lua -
--
-- Created by liubang on 2021/04/19 11:00
-- Last Modified: 2021/04/19 11:00
--
-- =====================================================================

local utils = require 'lb.utils.plugin'

PACKER_BOOTSTRAP = utils.bootstrap_packer()

local packer = require 'packer'

packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end,
  },
  git = {
    depth = 1,
    clone_timeout = 300,
  },
}

return packer.startup(function(use)
  -- have packer manage itself
  use { 'wbthomason/packer.nvim' }

  -- appearance
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'glepnir/dashboard-nvim' }
  use { 'sainnhe/gruvbox-material' }
  use { 'akinsho/nvim-bufferline.lua' }
  use { 'kyazdani42/nvim-tree.lua' }
  use { 'liubang/galaxyline.nvim' }

  -- performance
  use {
    'antoinemadec/FixCursorHold.nvim',
    run = function()
      vim.g.cursorhold_updatetime = 100
    end,
  }
  use { 'lewis6991/impatient.nvim' }

  -- tools
  use {
    'blackCauldron7/surround.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('surround').setup { mappings_style = 'sandwich' }
    end,
  }

  use {
    'norcalli/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle' },
    config = function()
      require('colorizer').setup()
    end,
  }

  use {
    'phaazon/hop.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hop').setup {}
    end,
  }

  use {
    'voldikss/vim-floaterm',
    cmd = { 'FloatermNew', 'FloatermToggle', 'FloatermPrev', 'FloatermNext', 'FloatermKill' },
    config = function()
      vim.g.floaterm_wintype = 'floating'
      vim.g.floaterm_position = 'center'
      vim.g.floaterm_autoinsert = true
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_title = 'terminal [$1/$2]'
      vim.cmd 'hi FloatermBorder guibg=#32302f guifg=#e78a4e'
    end,
  }

  use { 'skywind3000/asyncrun.vim' }
  use { 'skywind3000/asyncrun.extra' }
  use {
    'skywind3000/asynctasks.vim',
    config = function()
      vim.g.asyncrun_open = 25
      vim.g.asyncrun_bell = 1
      vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', '_darcs', 'build.xml' }
      vim.g.asynctasks_term_pos = 'floaterm'
      vim.g.asynctasks_term_reuse = 0
    end,
    cmd = { 'AsyncTask' },
  }

  use { 'nvim-lua/plenary.nvim' }
  use { 'tjdevries/astronauta.nvim' }
  use { 'sindrets/diffview.nvim', cmd = { 'DiffView' } }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'itchyny/vim-cursorword', event = { 'BufReadPre', 'BufNewFile' } }
  use { 'junegunn/vim-easy-align', keys = { '<Plug>(EasyAlign)' } }

  use { 'nvim-telescope/telescope-project.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim' }

  use { 'simrat39/symbols-outline.nvim', cmd = { 'SymbolsOutline' } }
  use { 'numToStr/Comment.nvim' }
  use { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'SmiteshP/nvim-gps' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- lsp
  use { 'tami5/lspsaga.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/nvim-lsp-installer' }

  -- completion
  use { 'windwp/nvim-autopairs' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-calc' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'hrsh7th/nvim-cmp' }

  -- ft
  use { 'cespare/vim-toml', ft = { 'toml' } }
  use { 'iamcco/markdown-preview.nvim', ft = 'markdown', run = 'cd app && yarn install' }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
