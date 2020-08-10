#! /bin/sh
#======================================================================
#
# install.sh -
#
# Created by liubang on 2020/08/10
# Last Modified: 2020/08/10 14:16
#
#======================================================================

nvim_version="v0.4.4"
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
  wget https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-macos.tar.gz -O /tmp/nvim.tar.gz
  archive_dir="nvim-osx64"
elif [ $ostype == 'linux' ]; then
  wget https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-linux64.tar.gz -O /tmp/nvim.tar.gz
  archive_dir="nvim-linux64"
fi
tar -zxvf /tmp/nvim.tar.gz -C /tmp/
if [ ! -d $HOME/bin ]; then
  mkdir $HOME/bin
fi
mv $archive_dir $HOME/bin/
pip3 install --user pynvim

# install dependencies
if [ $ostype == 'macos' ]; then
  brew install ripgrep
elif [ $ostype == 'linux' ]; then
  if [ $linux_type == 'centos' ]; then
    sudo yum-config-manager \ 
    --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum install ripgrep
  elif [$linux_type == 'ubuntu' ]; then
    sudo apt-get install ripgrep
  fi
fi

GO111MODULE=on go get mvdan.cc/sh/v3/cmd/shfmt

if [ ! -d $HOME/.config ]; then
  mkdir $HOME/.config
fi

if [ -d $HOME/.config/nvim ]; then
  mv $HOME/.config/nvim $HOME/.config/nvim.bak
fi

git clone --depth=1 https://github.com/liubang/vimrc.git $HOME/.config/nvim

if [ -f $HOME/.bashrc ]; then
  cat <<"EOF" >>$HOME/.bashrc
export PATH=$HOME/bin/nvim/bin:$PATH
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 $HOME/bin/nvim/bin/nvim'
EOF
fi

if [ -f $HOME/.zshrc]; then
  cat <<"EOF" >>$HOME/.zshrc
export PATH=$HOME/bin/nvim/bin:$PATH
alias vim='NVIM_TUI_ENABLE_TRUE_COLOR=1 $HOME/bin/nvim/bin/nvim'
EOF
fi
