local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input('Download Packer? (y for yes)') ~= 'y' then
    return
  end
  local directory = string.format('%s/site/pack/packer/opt/',
                                  vim.fn.stdpath('data'))
  vim.fn.mkdir(directory, 'p')
  local out = vim.fn.system(string.format('git clone %s %s',
                                          'https://github.com/wbthomason/packer.nvim',
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
      end,
    }
    use {'tpope/vim-surround'}
    use {
      'tpope/vim-fugitive',
      cmd = {'Gblame', 'Glog', 'Gdiff', 'Gstatus', 'Gpull', 'Grebase'},
    }
    use {'junegunn/gv.vim'}
    use {
      'mhinz/vim-signify',
      event = {'BufReadPre *', 'BufNewFile *'},
    }
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
        vim.g.asyncrun_rootmarks = {
          '.svn',
          '.git',
          '.root',
          '_darcs',
          'build.xml',
        }
        vim.g.asynctasks_term_pos = 'floaterm'
        vim.g.asynctasks_term_reuse = 0
      end,
    }
    use {
      'liuchengxu/vista.vim',
      cmd = {'Vista'},
      config = function()
        vim.g['vista#renderer#enable_icon'] = 1
        vim.g['vista_echo_cursor'] = 0
        vim.g['vista_fzf_preview'] = {right = '50%'}
        vim.g['vista_executive_for'] {
          vimwiki = 'markdown',
          pandoc = 'markdown',
          markdown = 'toc',
        }
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
    use {
      'hrsh7th/nvim-compe',
      requires = {
        'neovim/nvim-lspconfig',
        'norcalli/snippets.nvim',
        'hrsh7th/vim-vsnip',
      },
      config = function()
        require('lb.config.lsp')
      end,
    }

    -- ft
    use {'cespare/vim-toml', ft = {'toml'}}
    use {'neoclide/jsonc.vim', ft = {'jsonc', 'json'}}
    use {
      'iamcco/markdown-preview.nvim',
      ft = {'markdown', 'pandoc.markdown', 'rmd'},
      run = 'sh -c "cd app & yarn install"',
      config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 0
      end,
    }
  end,
  config = {},
}
