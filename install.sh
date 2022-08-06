#! /bin/bash
#======================================================================
#
# install.sh -
#
# Created by liubang on 2020/08/10
# Last Modified: 2020/08/10 14:16
#
#======================================================================

ostype=""
linux_type=""
case "$OSTYPE" in
  darwin*)
    ostype="macos"
    ;;
  linux*)
    ostype="linux"
    source /etc/os-release
    case $ID in
      debian | ubuntu)
        linux_type="ubuntu"
        ;;
      centos)
        linux_type="centos"
        ;;
      *) ;;
    esac
    ;;
esac

# install neovim
archive_dir=""
if [ $ostype == 'macos' ]; then
  wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz -O /tmp/nvim.tar.gz
  archive_dir="nvim-osx64"
elif [ $ostype == 'linux' ]; then
  wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz -O /tmp/nvim.tar.gz
  archive_dir="nvim-linux64"
fi
tar -zxvf /tmp/nvim.tar.gz -C /tmp/
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
mv $archive_dir $HOME/bin/

# install dependencies
if [ $ostype == 'macos' ]; then
  brew install ripgrep
  brew install ccls --HEAD
elif [ $ostype == 'linux' ]; then
  if [ $linux_type == 'centos' ]; then
    # install rg
    sudo yum-config-manager \
      --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum install ripgrep -y
    # install yarn
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
    sudo yum install yarn -y
    # build ccls
    sudo yum install epel-release -y
    sudo yum install snapd -y
    sudo systemctl enable --now snapd.socket
    sudo ln -s /var/lib/snapd/snap /snap
    sudo snap install ccls --classic
  elif [ $linux_type == 'ubuntu' ]; then
    # install rg
    sudo apt-get install ripgrep xclip -y
    # install yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn -y
    # build ccls
    cd /tmp && git clone --depth=1 --recursive https://github.com/MaskRay/ccls && cd ccls
    sudo apt install clang cmake libclang-dev llvm-dev rapidjson-dev -y
    cmake -H. -BRelease
    cmake --build Release
    cp Release/ccls $HOME/bin/
  fi
fi

# install shfmt
go install mvdan.cc/sh/v3/cmd/shfmt@latest

# buildifier
go install github.com/bazelbuild/buildtools/buildifier@latest

go install github.com/fatih/gomodifytags@latest

# luarocks install --server=https://luarocks.org/dev luaformatter

npm i -g bash-language-server
npm i -g vscode-json-languageserver
npm i -g yaml-language-server
npm i -g prettier
npm install -g intelephense

pip install --user cmake-language-server
pip install --user pynvim
pip3 install --user pynvim

if [ ! -d $HOME/.config ]; then
  mkdir $HOME/.config
fi

if [ -d $HOME/.config/nvim ]; then
  mv $HOME/.config/nvim $HOME/.config/nvim.bak
fi

git clone --depth=1 https://github.com/liubang/vimrc.git $HOME/.config/nvim

if [ -f "$HOME/.bashrc" ]; then
  cat <<"EOF" >>$HOME/.bashrc
export PATH=$HOME/bin/nvim/bin:$HOME/bin:$PATH
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 $HOME/bin/nvim/bin/nvim'
EOF
fi

if [ -f "$HOME/.zshrc" ]; then
  cat <<"EOF" >>$HOME/.zshrc
export PATH=$HOME/bin/nvim/bin:$HOME/bin:$PATH
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 $HOME/bin/nvim/bin/nvim'
EOF
fi
