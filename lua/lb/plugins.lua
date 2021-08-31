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

use {'justinmk/vim-sneak'}
use {'Raimondi/delimitMate'}
use {'tpope/vim-surround'}
use {'tpope/vim-fugitive', cmd = {'G'}, event = 'BufRead'}
use {'junegunn/gv.vim'}
use {'lewis6991/gitsigns.nvim'}
use {'itchyny/vim-cursorword', event = {'BufReadPre', 'BufNewFile'}}
use {'junegunn/vim-easy-align', keys = {'<Plug>(EasyAlign)'}}
use {'terryma/vim-expand-region'}
use {'voldikss/vim-floaterm'}

use {'skywind3000/asyncrun.vim'}
use {'skywind3000/asyncrun.extra'}
use {'skywind3000/asynctasks.vim'}
use {'junegunn/fzf', run = './install --all'}
use {'junegunn/fzf.vim'}
use {'liuchengxu/vista.vim', cmd = {'Vista'}}

use {'nvim-lua/plenary.nvim'}
use {'nvim-telescope/telescope.nvim'}
use {'nvim-telescope/telescope-project.nvim'}
use {'nvim-telescope/telescope-fzy-native.nvim'}
use {'nvim-telescope/telescope-fzf-writer.nvim'}
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}

-- use {'preservim/nerdcommenter'}
use {'b3nj5m1n/kommentary'}

use {'dstein64/vim-startuptime', cmd = {'StartupTime'}}

-- lsp
use {'glepnir/lspsaga.nvim'}
use {'tjdevries/nlua.nvim'}
use {'neovim/nvim-lspconfig'}

use {'hrsh7th/vim-vsnip'}
use {'GoldsteinE/compe-latex-symbols'}
use {'hrsh7th/nvim-compe'}

-- ft
use {'cespare/vim-toml', ft = {'toml'}}
use {'neoclide/jsonc.vim', ft = {'jsonc', 'json'}}
use {'masukomi/vim-markdown-folding', ft = {'markdown', 'rmd', 'pandoc.markdown'}}
use {'iamcco/markdown-preview.nvim', ft = 'markdown', run = 'cd app && yarn install'}
