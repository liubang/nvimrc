-- =====================================================================
--
-- plugins.lua -
--
-- Created by liubang on 2021/04/19 11:00
-- Last Modified: 2021/04/19 11:00
--
-- =====================================================================

local utils = require 'lb.utils.plugin'
local conf = utils.conf

utils.bootstrap_packer()

local packer = require 'packer'
local use = packer.use

-- local packer_compiled_path = vim.fn.stdpath 'data' .. '/site/lua/_compiled.lua'

packer.init {
  -- compile_path = packer_compiled_path,
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end,
  },
}
packer.reset()

use { 'wbthomason/packer.nvim', opt = true }
-- appearance
use { 'kyazdani42/nvim-web-devicons' }
use { 'glepnir/dashboard-nvim', config = conf 'dashboard' }
use { 'sainnhe/gruvbox-material', config = conf 'theme' }
use {
  'akinsho/nvim-bufferline.lua',
  config = function()
    require('bufferline').setup {
      options = {
        numbers = 'ordinal',
        close_icon = '\u{f18a}',
        modified_icon = '\u{fbba}',
        diagnostics = false,
        show_buffer_close_icons = false,
        always_show_bufferline = true,
      },
    }
  end,
}
use { 'liubang/galaxyline.nvim', config = conf 'status' }
use { 'kyazdani42/nvim-tree.lua', config = conf 'file_explorer' }

-- tools
use { 'lewis6991/impatient.nvim' }
use { 'tjdevries/astronauta.nvim' }
use { 'tpope/vim-surround', event = 'InsertEnter' }
use { 'sindrets/diffview.nvim', cmd = { 'DiffView' } }
use {
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    require('gitsigns').setup {
      signs = {
        add = { hl = 'GitGutterAdd', text = '▋' },
        change = { hl = 'GitGutterChange', text = '▋' },
        delete = { hl = 'GitGutterDelete', text = '▋' },
        topdelete = { hl = 'GitGutterDeleteChange', text = '▔' },
        changedelete = { hl = 'GitGutterChange', text = '▎' },
      },
      watch_gitdir = { interval = 1000, follow_files = true },
      current_line_blame = false,
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      word_diff = false,
      diff_opts = { internal = true },
    }
  end,
}
use { 'itchyny/vim-cursorword', event = { 'BufReadPre', 'BufNewFile' } }
use { 'junegunn/vim-easy-align', keys = { '<Plug>(EasyAlign)' } }
use { 'terryma/vim-expand-region', event = { 'BufRead', 'BufNewFile' } }
use {
  'voldikss/vim-floaterm',
  cmd = { 'FloatermNew', 'FloatermToggle', 'FloatermPrev', 'FloatermNext', 'FloatermKill' },
  config = function()
    vim.g.floaterm_wintype = 'floating'
    vim.g.floaterm_position = 'center'
    vim.g.floaterm_autoinsert = true
    vim.g.floaterm_title = 'terminal [$1/$2]'
    vim.cmd 'hi FloatermBorder guibg=#32302f guifg=#e78a4e'
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
  'skywind3000/asynctasks.vim',
  config = function()
    vim.g.asyncrun_open = 25
    vim.g.asyncrun_bell = 1
    vim.g.asyncrun_rootmarks = { '.svn', '.git', '.root', '_darcs', 'build.xml' }
    vim.g.asynctasks_term_pos = 'floaterm'
    vim.g.asynctasks_term_reuse = 0
  end,
  cmd = { 'AsyncTask' },
  requires = {
    'skywind3000/asyncrun.vim',
    'skywind3000/asyncrun.extra',
  },
}
use {
  'liuchengxu/vista.vim',
  cmd = { 'Vista' },
  config = function()
    vim.g.vista_echo_cursor = 0
    vim.g.vista_default_executive = 'nvim_lsp'
    vim.g.vista_no_mappings = 1
    vim.g.vista_sidebar_width = 40
    vim.g.vista_disable_statusline = 1
  end,
}

use { 'nvim-lua/plenary.nvim' }
use {
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-telescope/telescope-project.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
  },
  config = conf 'telescope',
}

use {
  'numToStr/Comment.nvim',
  event = 'InsertEnter',
  config = conf 'comment',
}

use { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } }

-- treesitter
use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  requires = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'p00f/nvim-ts-rainbow',
    'SmiteshP/nvim-gps',
  },
  config = conf 'treesitter',
}

-- lsp
use { 'tami5/lspsaga.nvim' }
use { 'neovim/nvim-lspconfig' }
use { 'williamboman/nvim-lsp-installer' }

-- completion
use {
  'L3MON4D3/LuaSnip',
  config = conf 'snip',
}
use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
use { 'hrsh7th/cmp-calc', after = 'nvim-cmp' }
use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
use { 'saadparwaiz1/cmp_luasnip', after = { 'nvim-cmp', 'LuaSnip' } }
use {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  requires = {
    'onsails/lspkind-nvim',
    'windwp/nvim-autopairs',
  },
  config = conf 'completion',
}

-- ft
use { 'cespare/vim-toml', ft = { 'toml' } }
use { 'iamcco/markdown-preview.nvim', ft = 'markdown', run = 'cd app && yarn install' }

-- if not vim.g.packer_compiled_loaded and vim.loop.fs_stat(packer_compiled_path) then
--   require '_compiled'
--   vim.g.packer_compiled_loaded = true
-- else
--   assert 'Missing packer compile file Run PackerCompile Or PackerInstall to fix'
-- end
