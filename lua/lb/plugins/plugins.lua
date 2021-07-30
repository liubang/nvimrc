-- =====================================================================
--
-- plugins.lua - 
--
-- Created by liubang on 2021/04/19 11:00
-- Last Modified: 2021/04/19 11:00
--
-- =====================================================================
vim.api.nvim_command [[packadd packer.nvim]]
local packer = require('packer')
local use = packer.use

packer.init({})
packer.reset()

use {'wbthomason/packer.nvim', opt = true}
-- appearance
use {'mortepau/codicons.nvim'}
use {
  'sainnhe/gruvbox-material',
  config = function()
    require('lb.config.theme')
  end,
}
use {
  'glepnir/dashboard-nvim',
  requires = {'ryanoasis/vim-devicons'},
  config = function()
    require('lb.config.dashboard-nvim')
  end,
}
use {
  'akinsho/nvim-bufferline.lua',
  requires = {'kyazdani42/nvim-web-devicons'},
  config = function()
    require('lb.config.nvim-bufferline')
  end,
}

use {
'nvim-lua/lsp-status.nvim'
}

use {
  'liubang/galaxyline.nvim',
  config = function()
    require('lb.config.eviline-gui')
  end,
}

use {
  'kyazdani42/nvim-tree.lua',
  requires = {'kyazdani42/nvim-web-devicons'},
  config = function()
    require('lb.config.nvim-tree').on_attach()
  end,
}

-- editor
-- use {
--   'easymotion/vim-easymotion',
--   config = function()
--     vim.g.EasyMotion_do_mapping = 0
--   end
-- }

use {
  'justinmk/vim-sneak',
  config = function()
    vim.g['sneak#label'] = 1
    vim.g['sneak#target_labels'] = ';sftunq/SFGHLTUNRMQZ?0'
    vim.g['sneak#use_ic_scs'] = 1
  end,
}

use {
  'Raimondi/delimitMate',
  config = function()
    vim.g.delimitMate_expand_cr = 0
    vim.g.delimitMate_expand_space = 1
    vim.g.delimitMate_smart_quotes = 1
    vim.g.delimitMate_expand_inside_quotes = 0
  end,
}
use {'tpope/vim-surround'}
use {
  'tpope/vim-fugitive',
  cmd = {'Gblame', 'Glog', 'Gdiff', 'Gstatus', 'Gpull', 'Grebase'},
}
use {'junegunn/gv.vim'}
use {'mhinz/vim-signify', event = {'BufReadPre', 'BufNewFile'}}
use {'itchyny/vim-cursorword', event = {'BufReadPre', 'BufNewFile'}}
use {'junegunn/vim-easy-align', keys = {'<Plug>(EasyAlign)'}}
use {'terryma/vim-expand-region'}
use {
  'voldikss/vim-floaterm',
  cmd = {
    'FloatermNew',
    'FloatermToggle',
    'FloatermPrev',
    'FloatermNext',
    'FloatermSend',
    'FloatermKill',
  },
  config = function()
    vim.g.floaterm_wintype = 'floating'
    vim.g.floaterm_position = 'center'
    vim.g.floaterm_autoinsert = true
    vim.g.floaterm_title = 'terminal [$1/$2]'
    vim.cmd('hi FloatermBorder guibg=#32302f guifg=#e78a4e')
  end,
}
use {
  'skywind3000/asynctasks.vim',
  requires = {'skywind3000/asyncrun.vim', 'skywind3000/asyncrun.extra'},
  config = function()
    vim.g.asyncrun_open = 25
    vim.g.asyncrun_bell = 1
    vim.g.asyncrun_rootmarks = {'.svn', '.git', '.root', '_darcs', 'build.xml'}
    vim.g.asynctasks_term_pos = 'floaterm'
    vim.g.asynctasks_term_reuse = 0
  end,
}
use {'junegunn/fzf', run = './install --all'}
use {'junegunn/fzf.vim'}
use {
  'liuchengxu/vista.vim',
  cmd = {'Vista'},
  config = function()
    require('lb.config.vista')
  end,
}
use {
  'nvim-telescope/telescope.nvim',
  requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
  config = function()
    require('lb.config.nvim-telescope')
  end,
}
use {
  'nvim-telescope/telescope-project.nvim',
  config = function()
    require('telescope').load_extension('project')
  end,
}
use {
  'nvim-telescope/telescope-fzy-native.nvim',
  after = 'telescope.nvim',
  config = function()
    require('telescope').load_extension('fzy_native')
  end,
}
use {
  'preservim/nerdcommenter',
  setup = function()
    vim.g['NERDCreateDefaultMappings'] = 0
    vim.g['NERDSpaceDelims'] = 1
    vim.g['NERDDefaultAlign'] = 'left'
  end,
}
use {
  'matze/vim-move',
  config = function()
    vim.g.move_key_modifier = 'C'
  end,
}
use {'dstein64/vim-startuptime', cmd = {'StartupTime'}}

-- lsp
use {'mfussenegger/nvim-jdtls'}
use {
  'neovim/nvim-lspconfig',
  requires = {'glepnir/lspsaga.nvim'},
  config = function()
    require('lb.config.lsp')
  end,
}

use {'tjdevries/nlua.nvim'}

use {
  'hrsh7th/nvim-compe',
  requires = {
    'norcalli/snippets.nvim',
    'hrsh7th/vim-vsnip',
    'GoldsteinE/compe-latex-symbols',
  },
  config = function()
    require('lb.config.nvim-compe')
  end,
}

-- ft
use {'cespare/vim-toml', ft = {'toml'}}
use {'neoclide/jsonc.vim', ft = {'jsonc', 'json'}}
use {
  'masukomi/vim-markdown-folding',
  ft = {'markdown', 'rmd', 'pandoc.markdown'},
}
use {
  'iamcco/markdown-preview.nvim',
  ft = {'markdown', 'pandoc.markdown', 'rmd'},
  run = 'sh -c "cd app & yarn install"',
  config = function()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 0
  end,
}
