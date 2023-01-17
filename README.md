<h1 align="center">My Neovim Configuration</h1>

<div align="center"><p>
    <a href="https://github.com/neovim/neovim">
        <img src="https://img.shields.io/badge/Neovim-0.8.2-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white" alt="Neovim"/>
    </a>
    <a href="https://github.com/liubang/nvimrc/actions">
        <img src="https://img.shields.io/github/actions/workflow/status/liubang/nvimrc/ci.yaml?style=flat-square&branch=main" alt="Build" />
    </a>
    <a href="#">
        <img src="https://img.shields.io/badge/platform-linux%20macOS-blue?style=flat-square" alt="Platform"/>
    </a>
    <a href="https://github.com/liubang/nvimrc/pulse">
        <img src="https://img.shields.io/github/last-commit/liubang/nvimrc?style=flat-square" alt="Last commit"/>
    </a>
    <a href="https://github.com/liubang/nvimrc/releases">
        <img src="https://img.shields.io/github/v/release/liubang/nvimrc?style=flat-square" alt="Release" />
    </a>
    <a href="https://github.com/liubang/nvimrc/blob/main/LICENSE">
        <img src="https://img.shields.io/github/license/liubang/nvimrc?style=flat-square&logo=MIT&label=License" alt="License"/>
    </a>
</p></div>

![nvim](./static/1.png)

![nvim](./static/2.png)

## ✨ Features

- Fast. Less than **30ms** to start (Depends on SSD and CPU, tested on Intel NUC11BTMi9).
- Simple. Run out of the box.
- Modern. Pure lua to config.
- Powerful. Full functionality to code.

![nvim](./static/3.png)

(Tested with [rhysd/vim-startuptime](https://github.com/rhysd/vim-startuptime))

## ⚡️ Requirements

- Neovim >= **0.8.2** (needs to be built with **LuaJIT**)
- Git >= **2.19.0** (for partial clones support)
- a [Nerd Font](https://www.nerdfonts.com/)

## 🚀 Getting Started

If you have [Docker](https://www.docker.com/) on your system you can try out this config via docker

### Just start nvim

```bash
docker run -it --rm liubang/nvim
```

### Mount a local directory and start nvim

```bash
docker run -it --rm -v $(pwd):/home/neovim/workspace liubang/nvim
```

## ⌨️ Keymaps

<!-- keymaps:start -->

<details><summary>General</summary>

| Key          | Description                                    | Mode         |
| ------------ | ---------------------------------------------- | ------------ |
| `<S-j>`      | move lines down                                | **n**, **x** |
| `<S-k>`      | move lines up                                  | **n**, **x** |
| `<Esc><Esc>` | clear hlsearch                                 | **n**        |
| `/`          | Search in visually selected region             | **x**        |
| `<`          | keep the visually selected area when indenting | **x**        |
| `>`          | keep the visually selected area when indenting | **x**        |
| `p`          | replace visually selected with the " contents  | **x**        |
| `<Leader>bp` | Previous                                       | **n**        |
| `<Leader>bn` | Next                                           | **n**        |
| `<Leader>bf` | First                                          | **n**        |
| `<Leader>bl` | Last                                           | **n**        |
| `<Leader>ww` | Toggle between open windows                    | **n**        |
| `<Leader>wh` | Move to the left window                        | **n**        |
| `<Leader>wl` | Move to the right window                       | **n**        |
| `<Leader>wj` | Move to the bottom window                      | **n**        |
| `<Leader>wk` | Move to the top window                         | **n**        |
| `<Leader>ws` | Split window horizontally                      | **n**        |
| `<Leader>wv` | Split window vertically                        | **n**        |

</details>

<details><summary>Plugins</summary>

| Key          | Description                                                                                                                 | Mode  |
| ------------ | --------------------------------------------------------------------------------------------------------------------------- | ----- |
| `<Leader>1`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 1th visible buffer                               | **n** |
| `<Leader>2`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 2th visible buffer                               | **n** |
| `<Leader>3`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 3th visible buffer                               | **n** |
| `<Leader>4`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 4th visible buffer                               | **n** |
| `<Leader>5`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 5th visible buffer                               | **n** |
| `<Leader>6`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 6th visible buffer                               | **n** |
| `<Leader>7`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 7th visible buffer                               | **n** |
| `<Leader>8`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 8th visible buffer                               | **n** |
| `<Leader>9`  | [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git) Goto the 9th visible buffer                               | **n** |
| `<Leader>ft` | [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua.git) Explorer nvim-tree                                          | **n** |
| `<Leader>ff` | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git) List files                                           | **n** |
| `<Leader>rf` | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git) List recent files                                    | **n** |
| `<Leader>ag` | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git) Grep in files                                        | **n** |
| `<Leader>Ag` | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git) Searches for the string under your cursor (root dir) | **n** |
| `<Leader>bb` | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git) Lists open buffers in current neovim instance        | **n** |
| `<Leader>ts` | [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git) Lists AsyncTasks for current buffer                  | **n** |

</details>

<!-- keymaps:end -->

## 📦 Plugins

<!-- plugins:start -->

- [accelerated-jk.nvim](https://github.com/rainbowhxch/accelerated-jk.nvim)
- [aerial.nvim](https://github.com/stevearc/aerial.nvim)
- [alpha-nvim](https://github.com/goolord/alpha-nvim)
- [asyncrun.extra](https://github.com/skywind3000/asyncrun.extra)
- [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim)
- [asynctasks.vim](https://github.com/skywind3000/asynctasks.vim)
- [bufdelete.nvim](https://github.com/famiu/bufdelete.nvim)
- [bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-calc](https://github.com/hrsh7th/cmp-calc)
- [cmp-latex-symbols](https://github.com/kdheepak/cmp-latex-symbols)
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
- [Comment.nvim](https://github.com/numToStr/Comment.nvim)
- [crates.nvim](https://github.com/saecki/crates.nvim)
- [fidget.nvim](https://github.com/j-hui/fidget.nvim)
- [fzy-lua-native](https://github.com/romgrk/fzy-lua-native)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [gruvbox-material](https://github.com/sainnhe/gruvbox-material)
- [hex.nvim](https://github.com/RaafatTurki/hex.nvim)
- [hop.nvim](https://github.com/phaazon/hop.nvim)
- [lspkind.nvim](https://github.com/onsails/lspkind.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://github.com/williamboman/mason.nvim)
- [mini.align](https://github.com/echasnovski/mini.align)
- [mini.cursorword](https://github.com/echasnovski/mini.cursorword)
- [mini.surround](https://github.com/echasnovski/mini.surround)
- [neodev.nvim](https://github.com/folke/neodev.nvim)
- [neogen](https://github.com/danymat/neogen)
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [nvim-colorizer.lua](https://github.com/NvChad/nvim-colorizer.lua)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-navic](https://github.com/SmiteshP/nvim-navic)
- [nvim-notify](https://github.com/rcarriga/nvim-notify)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- [playground](https://github.com/nvim-treesitter/playground)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim)
- [schemastore.nvim](https://github.com/b0o/schemastore.nvim)
- [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim)
- [sqlite.lua](https://github.com/kkharji/sqlite.lua)
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [undotree](https://github.com/mbbill/undotree)
- [venn.nvim](https://github.com/jbyuki/venn.nvim)
- [vim-caser](https://github.com/arthurxavierx/vim-caser)
- [vim-diagon](https://github.com/willchao612/vim-diagon)
- [vim-floaterm](https://github.com/voldikss/vim-floaterm)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [vim-git](https://github.com/tpope/vim-git)
- [vim-matchup](https://github.com/andymass/vim-matchup)
- [vim-startuptime](https://github.com/dstein64/vim-startuptime)
- [wilder.nvim](https://github.com/gelguy/wilder.nvim)
- [yanky.nvim](https://github.com/gbprod/yanky.nvim)

<!-- plugins:end -->
