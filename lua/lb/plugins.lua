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

require('packer').startup {
  function(use)
    use {'wbthomason/packer.nvim', opt = true}

    -- appearance
    use {
      'sainnhe/gruvbox-material',
      requires = {'kyazdani42/nvim-web-devicons', 'ryanoasis/vim-devicons'},
      config = function()
        require('lb.config.theme')
      end,
    }
    use {
      'mhinz/vim-startify',
      config = function()
        require('lb.config.vim-startify')
      end,
    }
    use {
      'akinsho/nvim-bufferline.lua',
      config = function()
        require('lb.config.nvim-bufferline')
      end,
    }
    use {
      'glepnir/galaxyline.nvim',
      config = function()
        require('lb.config.eviline')
      end,
    }
    use {
      'kyazdani42/nvim-tree.lua',
      config = function()
        require('lb.config.nvim-tree').on_attach()
      end,
    }

    -- editor
    use {
      -- 'jiangmiao/auto-pairs',
      'Raimondi/delimitMate',
      config = function()
        vim.g.delimitMate_expand_cr = 0
        vim.g.delimitMate_expand_space = 1
        vim.g.delimitMate_smart_quotes = 1
        vim.g.delimitMate_expand_inside_quotes = 0
      end
    }
    use {
      'itchyny/vim-cursorword',
      event = {'BufReadPre', 'BufNewFile'},
      config = function()
        require('lb.config.vim-cursorword')
      end,
    }
    use {'tpope/vim-surround'}
    use {'tpope/vim-fugitive', cmd = {'Gblame', 'Glog', 'Gdiff', 'Gstatus', 'Gpull', 'Grebase'}}
    use {'junegunn/gv.vim'}
    use {'junegunn/vim-easy-align', keys = {'<Plug>(EasyAlign)'}}
    use {'terryma/vim-expand-region'}
    use {
      'voldikss/vim-floaterm',
      cmd = {'FloatermNew', 'FloatermToggle', 'FloatermPrev', 'FloatermNext', 'FloatermSend', 'FloatermKill'},
      config = function()
        require('lb.config.vim-floaterm')
      end,
    }
    use {'skywind3000/asynctasks.vim', requires = {'skywind3000/asyncrun.vim', 'skywind3000/asyncrun.extra'}}
    use {
      'liuchengxu/vista.vim',
      cmd = {'Vista'},
      config = function()
        require('lb.config.vista')
      end,
    }
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim'}}
    use {
      'nvim-telescope/telescope-fzy-native.nvim',
      after = 'telescope.nvim',
      config = function()
        require('lb.config.nvim-telescope')
      end,
    }
    use {'brooth/far.vim'}
    use {
      'tyru/caw.vim',
      requires = 'kana/vim-operator-user',
      keys = {
        '<Plug>(caw:hatpos:toggle)',
        '<Plug>(caw:wrap:comment)',
        '<Plug>(caw:wrap:uncomment)',
        '<Plug>(caw:box:comment)',
        '<Plug>(caw:jump:comment-prev)',
        '<Plug>(caw:jump:comment-next)',
      }, 
    }
    use {
      'matze/vim-move',
      config = function()
        vim.g.move_key_modifier = 'C'
      end,
    }
    use {'dstein64/vim-startuptime', cmd = {'StartupTime'}}

    -- lsp
    use {
      'tjdevries/nlua.nvim',
    }

    use {
      'hrsh7th/nvim-compe',
      requires = {
        'neovim/nvim-lspconfig',
        'hrsh7th/vim-vsnip'
      },
      config = function()
        require('lb.config.lspconfig')
      end,
    }

    -- ft
    use {'cespare/vim-toml', ft = 'toml'}
    use {
      'iamcco/markdown-preview.nvim',
      ft = {'markdown', 'pandoc.markdown', 'rmd'},
      run = 'sh -c "cd app & yarn install"',
      config = function()
        require('lb.config.markdown-preview')
      end,
    }
  end,
  config = {},
}
