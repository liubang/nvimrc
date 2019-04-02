#!/bin/sh
#======================================================================
#
# install.sh - 
#
# Created by liubang on 2018/12/30
# Last Modified: 2018/12/30 23:40:41
#
#======================================================================

set -eo 

exit 1

if [ ! -n `which python3` ]; then
    echo "Please install python3"
    exit 1
fi

if [ ! -n `which pip3` ]; then
    echo "Please install pip3"
    exit 1
fi

if [ ! -n `which composer` ]; then
    echo "Please install composer"
    exit 1
fi

pip3 install --user neovim jedi psutil setproctitle neovim-remote

if [ "$(uname)" == "Darwin" ]; then
    brew install the_silver_searcher neovim
    brew install --HEAD universal-ctags/universal-ctags/universal-ctags
    brew install global
    ctags -f ~/.cache/tags/.tags -R \
        --c++-kinds=+px \
        --c-kinds=+px \
        --output-format=e-ctags \
        --fields=+niazS \
        --extras=+q /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include \
        /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks/Kernel.framework/Versions/A/Headers /usr/local/include 

else 
    source /etc/os-release
    case $ID in
        debian|ubuntu|devuan)
            sudo apt-get install silversearcher-ag global git neovim -y
            cd /tmp && git clone https://github.com/universal-ctags/ctags.git
            cd ctags && ./autogen.sh && ./configure && make && sudo make install
            ctags -f ~/.cache/tags/.tags -R \
                --c++-kinds=+px \
                --c-kinds=+px \
                --fields=+niazS \
                --output-format=e-ctags \
                --extras=+q /usr/include /usr/local/include
            rm -rf /tmp/ctags
            ;;
        centos|fedora|rhel)
            exit 1
            ;;
        *)
            exit 1
            ;;
    esac
fi

if [ -d "~/.vim" ]; then
    mv ~/.vim  ~/.vim.bak
fi

git clone https://github.com/iliubang/vimrc.git ~/.vim

if [ -d "~/.config" ]; then
    mkdir ~/.config
fi

ln -s ~/.vim ~/.config/nvim
cp ~/.vim/vim.custom.template  ~/.vim.custom
