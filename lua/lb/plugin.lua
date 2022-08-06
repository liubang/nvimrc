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
  auto_clean = true,
  compile_on_sync = true,
  display = {
    working_sym = 'ﲊ',
    error_sym = '✗ ',
    done_sym = ' ',
    removed_sym = ' ',
    moved_sym = '',
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
  use { 'goolord/alpha-nvim' }
  use { 'sainnhe/gruvbox-material' }
  use { 'akinsho/nvim-bufferline.lua', tag = 'v2.*' }
  use { 'nvim-lualine/lualine.nvim' }
  use { 'famiu/bufdelete.nvim', cmd = { 'Bdelete', 'Bwipeout' } }
  -- use { 'kyazdani42/nvim-tree.lua' }
  use { 'MunifTanjim/nui.nvim' }
  use { 's1n7ax/nvim-window-picker', tag = '1.*' }
  use { 'nvim-neo-tree/neo-tree.nvim', branch = 'v2.x' }

  -- performance
  use {
    'antoinemadec/FixCursorHold.nvim',
    run = function()
      vim.g.cursorhold_updatetime = 100
    end,
  }
  use { 'lewis6991/impatient.nvim' }

  -- tools
  -- use { 'mfussenegger/nvim-dap' }
  -- use { 'rcarriga/nvim-dap-ui' }
  -- use { 'theHamsta/nvim-dap-virtual-text' }
  use { 'folke/which-key.nvim' }
  use { 'rainbowhxch/accelerated-jk.nvim' }
  use { 'rcarriga/nvim-notify' }
  use { 'mrjones2014/smart-splits.nvim' }
  use { 'kylechui/nvim-surround' }

  use {
    'norcalli/nvim-colorizer.lua',
    cmd = { 'ColorizerToggle' },
    config = function()
      require('colorizer').setup()
    end,
  }

  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('hop').setup {}
    end,
  }

  use { 'anuvyklack/pretty-fold.nvim' }
  use { 'voldikss/vim-floaterm' }
  use { 'skywind3000/asyncrun.vim' }
  use { 'skywind3000/asyncrun.extra' }
  use { 'skywind3000/asynctasks.vim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'sindrets/diffview.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'itchyny/vim-cursorword', event = { 'BufReadPre', 'BufNewFile' } }
  use { 'junegunn/vim-easy-align', keys = { '<Plug>(EasyAlign)' } }

  use { 'nvim-telescope/telescope-project.nvim' }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  }
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }
  -- use { 'nvim-telescope/telescope-dap.nvim' }

  use { 'simrat39/symbols-outline.nvim', cmd = { 'SymbolsOutline' } }
  use { 'numToStr/Comment.nvim' }
  use { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'SmiteshP/nvim-navic' }

  -- lsp
  -- use { 'lewis6991/hover.nvim' }
  use { 'williamboman/mason.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'folke/lua-dev.nvim' }
  use { 'glepnir/lspsaga.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'j-hui/fidget.nvim' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'simrat39/rust-tools.nvim' }

  -- completion
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-calc' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/nvim-cmp' }

  use { 'windwp/nvim-autopairs' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }

  -- ft
  use { 'cespare/vim-toml', ft = { 'toml' } }
  use { 'iamcco/markdown-preview.nvim', ft = 'markdown', run = 'cd app && yarn install' }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
