# vimrc

[![GitHub release](https://img.shields.io/github/release/iliubang/vimrc.svg)](https://github.com/iliubang/vimrc/releases)

Configuration for neovim :rose:.

![screenshot](https://user-images.githubusercontent.com/13254917/55855557-6fc84d80-5b9a-11e9-8763-6df3b28ed4aa.png)

![screenshot](https://user-images.githubusercontent.com/13254917/58614382-c7f21500-82ea-11e9-9b7a-c3b63b60eb44.png)

## Docker

```shell
cd docker
docker build -t nvim .
docker run --it nvim
```

## Dependences

**Install [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)**

For Mac OS X (Recommend iTerm2)

```shell
brew install the_silver_searcher
```

For Ubuntu

```shell
sudo apt-get install silversearcher-ag
```

**Install ctags/gtags**

For Max OS X

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

# for lua
luarocks install --server=http://luarocks.org/dev lua-lsp

# for c/c++
# mac
brew install ccls
# or on linux see  https://github.com/MaskRay/ccls/wiki/Build#system-specific-notes
```

Install phpcs

[https://github.com/squizlabs/PHP_CodeSniffer](https://github.com/squizlabs/PHP_CodeSniffer)

**Install nerd-fonts**

[https://github.com/ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)

Recommend AnonymousPro.

**Install jdt.ls**

```shell
curl -fSL http://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz -o /opt/app/jdt-language-server-latest.tar.gz
tar -xf /opt/app/jdt-language-server-latest.tar.gz -C /opt/app/jdtls
```

**Install lombok**

```shell
curl -fSL https://projectlombok.org/downloads/lombok.jar -o /opt/app/jar/lombok.jar
```

**install rust**

```shell
curl https://sh.rustup.rs -sSf | sh
```

**install shellcheck**

```shell
brew install shellcheck
// or for ubuntu/debian
apt-get install shellcheck
```

## neovim

Install neovim

@See [https://github.com/neovim/neovim/wiki/Installing-Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

Install configuration

```shell
git clone https://github.com/iliubang/vimrc.git ~/.vim
ln -s ~/.vim ~/.config/nvim
nvim +PlugInstall +UpdateRemotePlugins +qall
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
" regist coder
function! Init()
  REG 'fe'
  REG 'clang'
  REG 'golang'
  REG 'python'
  REG 'sh'
  REG 'java'
  REG 'php'
  REG 'rust'
  REG 'docker'
endfunction

function! CustomPlug()
  " MMP 'dracula/vim', { 'as': 'dracula' }
endfunction

function! CustomConfig()
  " color dracula
endfunction
```
