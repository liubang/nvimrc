# vimrc

[![GitHub release](https://img.shields.io/github/release/iliubang/vimrc.svg)](https://github.com/iliubang/vimrc/releases)

Configuration for neovim :rose:.

![screenshot](https://user-images.githubusercontent.com/13254917/49992550-5bdf5700-ffbf-11e8-88e1-707b727f42ad.jpg)
![screenshot](https://user-images.githubusercontent.com/13254917/49992716-d27c5480-ffbf-11e8-91e1-5f92d65bedb0.png)

## Dependences 

**Install [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)**

For Mac OS X (Recommend iTerm2)

```shell
brew install the_silver_searcher ripgrep
```

For Ubuntu

```shell
sudo apt-get install silversearcher-ag ripgrep
```

**Install ctags/gtags**

For Max OS Xbox

```shell
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install global
```

For Ubuntu

```shell
git clone https://github.com/universal-ctags/ctags.git
cd ctags && ./autogen.sh && ./configure && make && sudo make install
sudo apt install global
```

**Install pip modules**

```shell
pip3 install --user pynvim
```

**Install lps servers**

```shell
# for bash
npm install -g bash-language-server

# for purescript
npm install -g purescript-language-server

# for dockerfile 
npm install -g dockerfile-language-server-nodejs

# for vim/eruby/markdown
go get github.com/mattn/efm-langserver/cmd/efm-langserver

# for php
npm install -g intelephense

# for lua
luarocks install --server=http://luarocks.org/dev lua-lsp

# for c/c++
# mac
brew install ccls

# or on linux see  https://github.com/MaskRay/ccls/wiki/Build#system-specific-notes
```

**Install nerd-fonts**

[https://github.com/ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)

Recommend AnonymousPro.

**Install jdt.ls**

```shell
curl -fSL http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz -o /opt/app/jdt-language-server-latest.tar.gz
tar -xf /opt/app/jdt-language-server-latest.tar.gz -C /opt/app/jdtls --strip-components=1
```

## neovim

Install neovim

@See [https://github.com/neovim/neovim/wiki/Installing-Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

Install configuration

```shell
git clone https://github.com/iliubang/vimrc.git ~/.vim
ln -s ~/.vim ~/.config/nvim
cp ~/.vim/efm-langserver.yaml ~/.config/efm-langserver/config.yaml
```

## Update

```shell
cd ~/.vim && git pull
```

## Custom configuration

```shell
cp ~/.vim/vim.custom.template ~/.vim.custom
```

**example:**

```viml
function! CustomPlug()
  " MMP 'dracula/vim', { 'as': 'dracula' }
endfunction

function! CustomConfig()
  " color dracula
endfunction
```
