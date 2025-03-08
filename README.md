<h1 align="center">My Neovim Configuration</h1>

<div align="center"><p>
    <a href="https://github.com/neovim/neovim">
        <img src="https://img.shields.io/badge/Neovim-0.10.0-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white" alt="Neovim"/>
    </a>
    <a href="https://github.com/liubang/nvimrc/actions">
        <img src="https://img.shields.io/github/actions/workflow/status/liubang/nvimrc/ci.yml?style=flat-square&branch=main" alt="Build" />
    </a>
    <a href="#">
        <img src="https://img.shields.io/badge/platform-linux%20macOS-blue?style=flat-square" alt="Platform"/>
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

## Features

- Fast. Less than **30ms** to start (Depends on SSD and CPU, tested on Intel NUC11BTMi9).
- Simple. Run out of the box.
- Modern. Pure lua to config.
- Powerful. Full functionality to code.

![nvim](./static/3.png)

(Tested with [rhysd/vim-startuptime](https://github.com/rhysd/vim-startuptime))

## Requirements

- Neovim >= **0.10.4** (needs to be built with **LuaJIT**)
- Git >= **2.19.0** (for partial clones support)
- a [Nerd Font](https://www.nerdfonts.com/)

## Getting Started

If you have [Docker](https://www.docker.com/) on your system you can try out this config via docker

### Just start nvim

```bash
docker run -it --rm liubang/nvim
```

### Mount a local directory and start nvim

```bash
docker run -it --rm -v $(pwd):/home/neovim/workspace liubang/nvim
```

## Keymaps

<!-- keymaps:start -->

| Key          | Description                                                                                                                                | Mode                |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------- |
| `n`          | Next search result                                                                                                                         | **n**, **x**, **o** |
| `N`          | Prev search result                                                                                                                         | **n**, **x**, **o** |
| `<S-j>`      | Move lines down                                                                                                                            | **n**, **x**        |
| `<S-k>`      | Move lines up                                                                                                                              | **n**, **x**        |
| `<Esc><Esc>` | Clear hlsearch                                                                                                                             | **n**               |
| `/`          | Search in visually selected region                                                                                                         | **x**               |
| `<`          | Keep the visually selected area when indenting                                                                                             | **x**               |
| `>`          | Keep the visually selected area when indenting                                                                                             | **x**               |
| `p`          | Rreplace visually selected with the " contents                                                                                             | **x**               |
| `<Leader>bp` | Previous                                                                                                                                   | **n**               |
| `<Leader>bn` | Next                                                                                                                                       | **n**               |
| `<Leader>bf` | First                                                                                                                                      | **n**               |
| `<Leader>bl` | Last                                                                                                                                       | **n**               |
| `<Leader>ww` | Toggle between open windows                                                                                                                | **n**               |
| `<leader>wd` | Delete window                                                                                                                              | **n**               |
| `<Leader>wh` | Move to the left window                                                                                                                    | **n**               |
| `<Leader>wl` | Move to the right window                                                                                                                   | **n**               |
| `<Leader>wj` | Move to the bottom window                                                                                                                  | **n**               |
| `<Leader>wk` | Move to the top window                                                                                                                     | **n**               |
| `<Leader>ws` | Split window horizontally                                                                                                                  | **n**               |
| `<Leader>wv` | Split window vertically                                                                                                                    | **n**               |
| `<C-Up>`     | Increase window height                                                                                                                     | **n**               |
| `<C-Down>`   | Decrease window height                                                                                                                     | **n**               |
| `<C-Left>`   | Decrease window width                                                                                                                      | **n**               |
| `<C-Right>`  | Increase window width                                                                                                                      | **n**               |
| `j`          | [accelerated-jk.nvim](https://ghfast.top/https://github.com/rainbowhxch/accelerated-jk.nvim) Accelerated gj movement                       | **n**               |
| `k`          | [accelerated-jk.nvim](https://ghfast.top/https://github.com/rainbowhxch/accelerated-jk.nvim) Accelerated gk movement                       | **n**               |
| `<Leader>tl` | [aerial.nvim](https://ghfast.top/https://github.com/stevearc/aerial.nvim) Open or close the aerial window                                  | **n**               |
| `<C-b>`      | [asynctasks.vim](https://ghfast.top/https://github.com/skywind3000/asynctasks.vim) Build current file                                      | **n**               |
| `<C-r>`      | [asynctasks.vim](https://ghfast.top/https://github.com/skywind3000/asynctasks.vim) Run current file                                        | **n**               |
| `<C-x>`      | [asynctasks.vim](https://ghfast.top/https://github.com/skywind3000/asynctasks.vim) Build and run current file                              | **n**               |
| `<Leader>1`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 1th visible buffer                               | **n**               |
| `<Leader>2`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 2th visible buffer                               | **n**               |
| `<Leader>3`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 3th visible buffer                               | **n**               |
| `<Leader>4`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 4th visible buffer                               | **n**               |
| `<Leader>5`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 5th visible buffer                               | **n**               |
| `<Leader>6`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 6th visible buffer                               | **n**               |
| `<Leader>7`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 7th visible buffer                               | **n**               |
| `<Leader>8`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 8th visible buffer                               | **n**               |
| `<Leader>9`  | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Goto the 9th visible buffer                               | **n**               |
| `<leader>bo` | [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim) Delete other buffers                                      | **n**               |
| `s`          | [flash.nvim](https://ghfast.top/https://github.com/folke/flash.nvim) Flash                                                                 | **n**, **x**, **o** |
| `S`          | [flash.nvim](https://ghfast.top/https://github.com/folke/flash.nvim) Flash Treesitter                                                      | **n**, **x**, **o** |
| `r`          | [flash.nvim](https://ghfast.top/https://github.com/folke/flash.nvim) Remote Flash                                                          | **o**               |
| `R`          | [flash.nvim](https://ghfast.top/https://github.com/folke/flash.nvim) Treesitter Search                                                     | **o**, **x**        |
| `<Leader>hb` | [gitsigns.nvim](https://ghfast.top/https://github.com/lewis6991/gitsigns.nvim) Show the line git blame in a floating window                | **n**               |
| `<Leader>hd` | [gitsigns.nvim](https://ghfast.top/https://github.com/lewis6991/gitsigns.nvim) Perform a `vimdiff` on the given file                       | **n**               |
| `<Leader>hr` | [gitsigns.nvim](https://ghfast.top/https://github.com/lewis6991/gitsigns.nvim) Reset the lines of the hunk at the cursor position          | **n**               |
| `<Leader>hs` | [gitsigns.nvim](https://ghfast.top/https://github.com/lewis6991/gitsigns.nvim) Stage the hunk at the cursor position                       | **n**               |
| `<leader>sr` | [grug-far.nvim](https://ghfast.top/https://github.com/MagicDuck/grug-far.nvim) Search and Replace                                          | **n**, **v**        |
| `<Leader>mp` | [markdown-preview.nvim](https://ghfast.top/https://github.com/iamcco/markdown-preview.nvim) Markdown Preview                               | **n**               |
| `<leader>bd` | [mini.bufremove](https://ghfast.top/https://github.com/echasnovski/mini.bufremove) Delete Buffer                                           | **n**               |
| `<leader>bD` | [mini.bufremove](https://ghfast.top/https://github.com/echasnovski/mini.bufremove) Delete Buffer (Force)                                   | **n**               |
| `gc`         | [mini.comment](https://ghfast.top/https://github.com/echasnovski/mini.comment) Toggle line comment                                         | **n**, **x**        |
| `gcc`        | [mini.comment](https://ghfast.top/https://github.com/echasnovski/mini.comment) Toggle line comment                                         | **n**               |
| `<leader>ft` | [mini.files](https://ghfast.top/https://github.com/echasnovski/mini.files) Toggle mini.files (Directory of Current File)                   | **n**               |
| `<leader>fT` | [mini.files](https://ghfast.top/https://github.com/echasnovski/mini.files) Toggle mini.files (cwd)                                         | **n**               |
| `<leader>dB` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Breakpoint Condition                                               | **n**               |
| `<leader>db` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Toggle Breakpoint                                                  | **n**               |
| `<leader>dc` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Continue                                                           | **n**               |
| `<leader>da` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Run with Args                                                      | **n**               |
| `<leader>dC` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Run to Cursor                                                      | **n**               |
| `<leader>dl` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Run Last                                                           | **n**               |
| `<leader>di` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Step Into                                                          | **n**               |
| `<leader>do` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Step Out                                                           | **n**               |
| `<leader>dO` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Step Over                                                          | **n**               |
| `<leader>dp` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Pause                                                              | **n**               |
| `<leader>dt` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Terminate                                                          | **n**               |
| `<leader>dj` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Down                                                               | **n**               |
| `<leader>dk` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Up                                                                 | **n**               |
| `<leader>dg` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Go to Line (No Execute)                                            | **n**               |
| `<leader>ds` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Session                                                            | **n**               |
| `<leader>dr` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Toggle REPL                                                        | **n**               |
| `<leader>dw` | [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap) Widgets                                                            | **n**               |
| `<leader>du` | [nvim-dap-ui](https://ghfast.top/https://github.com/rcarriga/nvim-dap-ui) Dap UI                                                           | **n**               |
| `<leader>de` | [nvim-dap-ui](https://ghfast.top/https://github.com/rcarriga/nvim-dap-ui) Eval                                                             | **n**, **v**        |
| `<C-v>`      | [nvim-treesitter](https://ghfast.top/https://github.com/nvim-treesitter/nvim-treesitter) Increment Selection                               | **n**               |
| `V`          | [nvim-treesitter](https://ghfast.top/https://github.com/nvim-treesitter/nvim-treesitter) Decrement Selection                               | **x**               |
| `-`          | [oil.nvim](https://ghfast.top/https://github.com/stevearc/oil.nvim) Open parent directory                                                  | **n**               |
| `<Leader>-`  | [oil.nvim](https://ghfast.top/https://github.com/stevearc/oil.nvim) Open parent directory                                                  | **n**               |
| `<Leader>ff` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) List files                                           | **n**               |
| `<Leader>rf` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) List recent files                                    | **n**               |
| `<Leader>ag` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) Grep in files                                        | **n**               |
| `<Leader>Ag` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) Searches for the string under your cursor (root dir) | **n**               |
| `<Leader>bb` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) Lists open buffers in current neovim instance        | **n**               |
| `<Leader>ts` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) Lists AsyncTasks for current buffer                  | **n**               |
| `<Leader>br` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) Bazl run                                             | **n**               |
| `<Leader>bt` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) Bazel test                                           | **n**               |
| `<Leader>bs` | [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim) Bazel build                                          | **n**               |
| `<leader>vv` | [venn.nvim](https://ghfast.top/https://github.com/jbyuki/venn.nvim) Toggle draw box                                                        | **n**               |
| `<C-t>`      | [vim-floaterm](https://ghfast.top/https://github.com/voldikss/vim-floaterm) Toggle floaterm                                                | **n**, **t**        |
| `<C-n>`      | [vim-floaterm](https://ghfast.top/https://github.com/voldikss/vim-floaterm) Create a new floaterm window                                   | **t**               |
| `<C-k>`      | [vim-floaterm](https://ghfast.top/https://github.com/voldikss/vim-floaterm) Goto previous floaterm window                                  | **t**               |
| `<C-j>`      | [vim-floaterm](https://ghfast.top/https://github.com/voldikss/vim-floaterm) Goto next floaterm window                                      | **t**               |
| `<C-d>`      | [vim-floaterm](https://ghfast.top/https://github.com/voldikss/vim-floaterm) Kill floaterm                                                  | **t**               |
| `]]`         | [vim-illuminate](https://ghfast.top/https://github.com/RRethy/vim-illuminate) Next Reference                                               | **n**               |
| `[[`         | [vim-illuminate](https://ghfast.top/https://github.com/RRethy/vim-illuminate) Prev Reference                                               | **n**               |

<!-- keymaps:end -->

## Plugins

<!-- plugins:start -->

- [accelerated-jk.nvim](https://ghfast.top/https://github.com/rainbowhxch/accelerated-jk.nvim)
- [aerial.nvim](https://ghfast.top/https://github.com/stevearc/aerial.nvim)
- [alpha-nvim](https://ghfast.top/https://github.com/goolord/alpha-nvim)
- [asyncrun.vim](https://ghfast.top/https://github.com/skywind3000/asyncrun.vim)
- [asynctasks.vim](https://ghfast.top/https://github.com/skywind3000/asynctasks.vim)
- [blink.cmp](https://ghfast.top/https://github.com/saghen/blink.cmp)
- [bufferline.nvim](https://ghfast.top/https://github.com/akinsho/bufferline.nvim)
- [clangd_extensions.nvim](https://ghfast.top/https://github.com/p00f/clangd_extensions.nvim)
- [diffview.nvim](https://ghfast.top/https://github.com/sindrets/diffview.nvim)
- [flash.nvim](https://ghfast.top/https://github.com/folke/flash.nvim)
- [friendly-snippets](https://ghfast.top/https://github.com/rafamadriz/friendly-snippets)
- [fzy-lua-native](https://ghfast.top/https://github.com/romgrk/fzy-lua-native)
- [gitsigns.nvim](https://ghfast.top/https://github.com/lewis6991/gitsigns.nvim)
- [grug-far.nvim](https://ghfast.top/https://github.com/MagicDuck/grug-far.nvim)
- [gruvbox-material](https://ghfast.top/https://github.com/sainnhe/gruvbox-material)
- [lazy.nvim](https://ghfast.top/https://github.com/folke/lazy.nvim)
- [lazydev.nvim](https://ghfast.top/https://github.com/folke/lazydev.nvim)
- [lua-async-await](https://ghfast.top/https://github.com/nvim-java/lua-async-await)
- [lualine.nvim](https://ghfast.top/https://github.com/nvim-lualine/lualine.nvim)
- [LuaSnip](https://ghfast.top/https://github.com/L3MON4D3/LuaSnip)
- [markdown-preview.nvim](https://ghfast.top/https://github.com/iamcco/markdown-preview.nvim)
- [mason-lspconfig.nvim](https://ghfast.top/https://github.com/williamboman/mason-lspconfig.nvim)
- [mason.nvim](https://ghfast.top/https://github.com/williamboman/mason.nvim)
- [mini.align](https://ghfast.top/https://github.com/echasnovski/mini.align)
- [mini.bufremove](https://ghfast.top/https://github.com/echasnovski/mini.bufremove)
- [mini.comment](https://ghfast.top/https://github.com/echasnovski/mini.comment)
- [mini.files](https://ghfast.top/https://github.com/echasnovski/mini.files)
- [mini.icons](https://ghfast.top/https://github.com/echasnovski/mini.icons)
- [mini.pairs](https://ghfast.top/https://github.com/echasnovski/mini.pairs)
- [mini.surround](https://ghfast.top/https://github.com/echasnovski/mini.surround)
- [neogen](https://ghfast.top/https://github.com/danymat/neogen)
- [noice.nvim](https://ghfast.top/https://github.com/folke/noice.nvim)
- [none-ls.nvim](https://ghfast.top/https://github.com/nvimtools/none-ls.nvim)
- [nui.nvim](https://ghfast.top/https://github.com/MunifTanjim/nui.nvim)
- [nvim-dap](https://ghfast.top/https://github.com/mfussenegger/nvim-dap)
- [nvim-dap-go](https://ghfast.top/https://github.com/leoluz/nvim-dap-go)
- [nvim-dap-ui](https://ghfast.top/https://github.com/rcarriga/nvim-dap-ui)
- [nvim-dap-virtual-text](https://ghfast.top/https://github.com/theHamsta/nvim-dap-virtual-text)
- [nvim-java](https://ghfast.top/https://github.com/nvim-java/nvim-java)
- [nvim-java-core](https://ghfast.top/https://github.com/nvim-java/nvim-java-core)
- [nvim-java-dap](https://ghfast.top/https://github.com/nvim-java/nvim-java-dap)
- [nvim-java-refactor](https://ghfast.top/https://github.com/nvim-java/nvim-java-refactor)
- [nvim-java-test](https://ghfast.top/https://github.com/nvim-java/nvim-java-test)
- [nvim-lspconfig](https://ghfast.top/https://github.com/neovim/nvim-lspconfig)
- [nvim-navic](https://ghfast.top/https://github.com/SmiteshP/nvim-navic)
- [nvim-nio](https://ghfast.top/https://github.com/nvim-neotest/nvim-nio)
- [nvim-tree.lua](https://ghfast.top/https://github.com/nvim-tree/nvim-tree.lua)
- [nvim-treesitter](https://ghfast.top/https://github.com/nvim-treesitter/nvim-treesitter)
- [oil.nvim](https://ghfast.top/https://github.com/stevearc/oil.nvim)
- [plenary.nvim](https://ghfast.top/https://github.com/nvim-lua/plenary.nvim)
- [rust-tools.nvim](https://ghfast.top/https://github.com/simrat39/rust-tools.nvim)
- [schemastore.nvim](https://ghfast.top/https://github.com/b0o/schemastore.nvim)
- [smartyank.nvim](https://ghfast.top/https://github.com/ibhagwan/smartyank.nvim)
- [spring-boot.nvim](https://ghfast.top/https://github.com/JavaHello/spring-boot.nvim)
- [telescope-fzf-native.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [telescope-live-grep-args.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope-live-grep-args.nvim)
- [telescope-ui-select.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope-ui-select.nvim)
- [telescope-undo.nvim](https://ghfast.top/https://github.com/debugloop/telescope-undo.nvim)
- [telescope.nvim](https://ghfast.top/https://github.com/nvim-telescope/telescope.nvim)
- [tla.nvim](https://ghfast.top/https://github.com/liubang/tla.nvim)
- [venn.nvim](https://ghfast.top/https://github.com/jbyuki/venn.nvim)
- [vim-caser](https://ghfast.top/https://github.com/arthurxavierx/vim-caser)
- [vim-diagon](https://ghfast.top/https://github.com/willchao612/vim-diagon)
- [vim-floaterm](https://ghfast.top/https://github.com/voldikss/vim-floaterm)
- [vim-illuminate](https://ghfast.top/https://github.com/RRethy/vim-illuminate)
- [vim-matchup](https://ghfast.top/https://github.com/andymass/vim-matchup)
- [wilder.nvim](https://ghfast.top/https://github.com/gelguy/wilder.nvim)

<!-- plugins:end -->
