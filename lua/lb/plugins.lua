-- =====================================================================
--
-- plugins.lua - 
--
-- Created by liubang on 2021/04/19 11:00
-- Last Modified: 2021/04/19 11:00
--
-- =====================================================================
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
if not packer_exists then
  if vim.fn.input('Download Packer? (y for yes)') ~= 'y' then
    return
  end
  local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath('data'))
  vim.fn.mkdir(directory, 'p')
  local out = vim.fn.system(string.format('git clone %s %s',
                                          'https://github.com/wbthomason/packer.nvim',
                                          directory .. '/packer.nvim'))
  print(out)
  print('Downloading packer.nvim...')
  return
end

local packer = require('packer')
local use = packer.use

packer.init({})
packer.reset()

use {'wbthomason/packer.nvim', opt = true}
-- appearance
use {'mortepau/codicons.nvim'}
use {'ryanoasis/vim-devicons'}
use {'kyazdani42/nvim-web-devicons'}

use {'sainnhe/gruvbox-material'}
use {'glepnir/dashboard-nvim'}
use {'akinsho/nvim-bufferline.lua'}
use {'liubang/galaxyline.nvim'}
use {'kyazdani42/nvim-tree.lua'}

use {'windwp/nvim-autopairs'}
use {'tpope/vim-surround'}
use {'karb94/neoscroll.nvim'}
use {'sindrets/diffview.nvim'}
use {'lewis6991/gitsigns.nvim'}
use {'itchyny/vim-cursorword', event = {'BufReadPre', 'BufNewFile'}}
use {'junegunn/vim-easy-align', keys = {'<Plug>(EasyAlign)'}}
use {'terryma/vim-expand-region'}
use {'voldikss/vim-floaterm'}
use {'phaazon/hop.nvim'}

use {'skywind3000/asyncrun.vim'}
use {'skywind3000/asyncrun.extra'}
use {'skywind3000/asynctasks.vim'}
-- use {'junegunn/fzf', run = './install --all'}
-- use {'junegunn/fzf.vim'}
use {'liuchengxu/vista.vim', cmd = {'Vista'}}
use {'romgrk/fzy-lua-native'}
use {'gelguy/wilder.nvim'}

use {'nvim-lua/plenary.nvim'}
use {'nvim-telescope/telescope.nvim'}
use {'nvim-telescope/telescope-project.nvim'}
use {'nvim-telescope/telescope-fzy-native.nvim'}
use {'nvim-telescope/telescope-fzf-writer.nvim'}
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

use {'b3nj5m1n/kommentary'}

use {'dstein64/vim-startuptime', cmd = {'StartupTime'}}

-- lsp
use {'tami5/lspsaga.nvim', branch = 'nvim51'}
use {'tjdevries/nlua.nvim'}
use {'neovim/nvim-lspconfig'}
use {'onsails/lspkind-nvim'}
use {'nvim-lua/lsp_extensions.nvim'}

-- completion
use {'hrsh7th/nvim-cmp'}
use {'hrsh7th/cmp-buffer'}
use {'hrsh7th/cmp-path'}
use {'hrsh7th/cmp-calc'}
use {'hrsh7th/cmp-nvim-lua'}
use {'hrsh7th/cmp-nvim-lsp'}
use {'saadparwaiz1/cmp_luasnip'}
use {'L3MON4D3/LuaSnip'}

-- ft
use {'cespare/vim-toml', ft = {'toml'}}
use {'neoclide/jsonc.vim', ft = {'jsonc', 'json'}}
use {'masukomi/vim-markdown-folding', ft = {'markdown', 'rmd', 'pandoc.markdown'}}
use {'iamcco/markdown-preview.nvim', ft = 'markdown', run = 'cd app && yarn install'}
