# vimrc

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/iliubang/vimrc/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/iliubang/vimrc.svg)](https://github.com/iliubang/vimrc/releases)

Configuration for neovim/vim8.

![screenshot](./screenshot/s1.png)
![screenshot](./screenshot/2.png)
![screenshot](./screenshot/3.png)

## Dependences 

**Install [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)**

For Mac OS X

```shell
brew install the_silver_searcher
```

For Ubuntu

```shell
sudo apt-get install silversearcher-ag 
```

**Install ctags/gtags**

For Mac OS X

```shell
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install global --with-ctags
```

For Ubuntu

```shell
sudo apt install exuberant-ctags
sudo apt install global
```

**Install pip modules**

```shell
pip3 install --user neovim jedi psutil setproctitle
```

## vim8

Install vim8 with python3 and lua support.

For Mac OS X:

```shell
brew install vim --with-python3 --with-lua --override-system-vim --with-client-server
```

For Linux/Unix:

Install dependencies

```shell
sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev clang\
    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
    python3-dev ruby-dev lua5.1 lua5.1-dev libperl-dev git -y
```

Compile and install

```shell
cd ~
git clone https://github.com/vim/vim.git
cd vim
./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.6/config-x86_64-linux-gnu \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
sudo make install 
```

Then install configuration

```shell
git clone https://github.com/iliubang/vimrc.git ~/.vim
ln -s ~/.vim/init.vim ~/.vimrc
```

## neovim

Install neovim

@See [https://github.com/neovim/neovim/wiki/Installing-Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

Install configuration

```shell
git clone https://github.com/iliubang/vimrc.git ~/.vim
ln -s ~/.vim ~/.config/nvim
```

## Update

```shell
cd ~/.vim && git pull
```

## Components

**Internal components**

- better
- completor
- startify
- editor
- theme
- fzf
- tags

**Optional components**

- markdown
- go
- php
- python
- clang
- latex

## Custom configuration

```shell
cp ~/.vim/vim.custom.template ~/.vim.custom
```

**example:**

```viml
function! CustomPlug()
    " add a component
    Component 'go'
    Component 'php'
    Component 'python'
    Component 'clang'
    Component 'latex'
    " or add a plugin
    " Plug 'sickill/vim-monokai'
endfunction

function! CustomConfig()
    set t_Co=256
    set laststatus=2
    set background=dark
    colorscheme monokai
endfunction
```

## Usage

**About Leader Key:**

The `<leader>` key is mapped to '\<Space>'.

### Main shortcut keys

| Command          | Description                                                         |
|------------------|---------------------------------------------------------------------|
| <leader>ff       | Search files in current path                                        |
| <leader>f?       | Search files in root path                                           |
| <leader>ft       | Toggle nerdtree                                                     |
| F4               | Toggle nerdtree                                                     |
| F3               | Toggle tagbar                                                       |
| <leader>tf       | Format the table under the cursor                                   |
| <leader>cc       | Comment out the current line or text selected in visual mode        |
| <leader>cu       | Uncomments the selected line(s)                                     |
| <leader>cn       | Same as cc but forces nesting                                       |
| <leader>c<space> | Toggles the comment state of the selected line(s)                   |
| <leader>cm       | Comments the given lines using only one set of multipart delimiters |
| zc               | Fold code                                                           |
| zo               | Unfold the code                                                     |
| za               | Toggle the folding state of code                                    |
| zm               | Unfold all                                                          |
| zr               | Fold all                                                            |

## Plugins

### nerdtree

@See: [https://github.com/scrooloose/nerdtree/blob/master/doc/NERDTree.txt](https://github.com/scrooloose/nerdtree/blob/master/doc/NERDTree.txt)

### nerdcommenter

@See: [https://github.com/scrooloose/nerdcommenter](https://github.com/scrooloose/nerdcommenter)

### vimtex

@See: [https://github.com/lervag/vimtex/wiki/Usage](https://github.com/lervag/vimtex/wiki/Usage)

### vim-go

@See: [https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt](https://github.com/fatih/vim-go/blob/master/doc/vim-go.txt)

### phpcd.vim

@See: [https://github.com/lvht/phpcd.vim](https://github.com/lvht/phpcd.vim)

### deoplete-clangx

@See: [https://github.com/Shougo/deoplete-clangx](https://github.com/Shougo/deoplete-clangx)
