local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input('Download Packer? (y for yes)') ~= 'y' then
    return
  end
  local directory = string.format('%s/site/pack/packer/opt/', vim.fn.stdpath('data'))
  vim.fn.mkdir(directory, 'p')
  local out = vim.fn.system(string.format('git clone %s %s', 'https://github.com/wbthomason/packer.nvim',
                                          directory .. '/packer.nvim'))
  print(out)
  print('Downloading packer.nvim...')
  return
end

local packer = require('packer')

packer.startup {
  function(use)
    use {'wbthomason/packer.nvim', opt = true}
    use {
      'sainnhe/gruvbox-material',
      requires = {'kyazdani42/nvim-web-devicons', 'ryanoasis/vim-devicons'},
      config = require('lb.config.theme'),
    }
    use {'mhinz/vim-startify', config = require('lb.config.vim-startify')}
    use {
      'mengelbrecht/lightline-bufferline',
      requires = 'itchyny/lightline.vim',
      config = require('lb.config.lightline').on_attach(),
    }
    use {'kyazdani42/nvim-tree.lua', config = require('lb.config.nvim-tree').on_attach()}

    use {'itchyny/vim-cursorword', event = {'BufReadPre', 'BufNewFile'}, config = require('lb.config.vim-cursorword')}

    use 'tpope/vim-surround'
    use {'tpope/vim-fugitive', cmd = {'Gblame', 'Glog', 'Gdiff', 'Gstatus', 'Gpull', 'Grebase'}}
    use 'junegunn/gv.vim'
    use 'junegunn/vim-easy-align'
    use 'terryma/vim-expand-region'
    use {
      'voldikss/vim-floaterm',
      cmd = {'FloatermNew', 'FloatermToggle', 'FloatermPrev', 'FloatermNext', 'FloatermSend', 'FloatermKill'},
      config = require('lb.config.vim-floaterm'),
    }
    use {'skywind3000/asynctasks.vim', requires = 'skywind3000/asyncrun.vim'}
    use {'liuchengxu/vista.vim', cmd = {'Vista', 'Vista!', 'Vista!!'}, config = require('lb.config.vista')}
    use {
      'nvim-telescope/telescope.nvim',
      requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'},
      config = require('lb.config.nvim-telescope'),
    }
    use {'tyru/caw.vim', requires = 'kana/vim-operator-user'}
    use 'matze/vim-move'
    use 'dstein64/vim-startuptime'

    use {'neoclide/coc.nvim', branch = 'release', config = require('lb.config.coc').on_attach()}

    use {'cespare/vim-toml', ft = 'toml'}
    use {'neoclide/jsonc.vim', ft = {'json', 'jsonc'}}
    use {'plasticboy/vim-markdown', ft = 'markdown', config = require('lb.config.vim-markdown')}
    use {
      'iamcco/markdown-preview.nvim',
      ft = {'markdown', 'pandoc.markdown', 'rmd'},
      run = 'sh -c "cd app & yarn install"',
      config = require('lb.config.markdown-preview'),
    }
    use {'z0mbix/vim-shfmt', ft = 'sh', config = require('lb.config.vim-shfmt')}
    use {
      'rhysd/vim-clang-format',
      ft = {'c', 'cpp'},
      cmd = 'ClangFormat',
      config = require('lb.config.vim-clang-format'),
    }
  end,
}
