FROM debian:stable

ENV NVIM_VERSION="v0.8.1"
ENV HOME=/home/neovim

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    apt-transport-https \
    curl \
    git \
    npm \
    python3 \
    python3-pip \
    autoconf \
    automake \
    make \
    cmake \
    gcc \
    g++ \
    pkg-config \
    unzip \
    lua5.3 \
    nodejs \
    ripgrep && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupdel users                                              \
  && groupadd -r neovim                                         \
  && useradd --create-home --home-dir $HOME                     \
             -r -g neovim                                       \
             neovim

RUN mkdir -p /opt/app && \
    cd /tmp && \
    curl -sLf https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.tar.gz -o nvim-linux64.tar.gz && \
    tar -zxvf nvim-linux64.tar.gz && \
    mv nvim-linux64 /opt/app/nvim && \
    rm nvim-linux64.tar.gz && \
    curl -sLf https://go.dev/dl/go1.19.3.linux-amd64.tar.gz -o go1.19.3.linux-amd64.tar.gz && \
    tar -zxvf go1.19.3.linux-amd64.tar.gz && \
    mv go /opt/app/go && \
    rm -rf /opt/app/go/api && \
    rm -rf /opt/app/go/doc && \
    rm -rf /opt/app/go/test && \
    rm -rf /opt/app/go/lib && \
    rm go1.19.3.linux-amd64.tar.gz

USER neovim

ENV PYTHON3_HOST_PROG="/usr/bin/python3"
ENV PATH=$PATH:/opt/app/nvim/bin:/opt/app/go/bin

RUN mkdir -p $HOME/.config && \
    mkdir -p $HOME/workspace && \
    cd $HOME && \
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/opt/packer.nvim && \
    git clone --depth 1  https://github.com/liubang/nvimrc.git $HOME/.config/nvim && \
    rm -rf $HOME/.config/nvim/.github && \
    rm -rf $HOME/.config/nvim/.git && \
    rm -rf $HOME/.config/nvim/static && \
    rm -rf $HOME/.config/nvim/scratch && \
    pip install --user pynvim && \
    go env -w GO111MODULE=on && \
    go env -w GOPATH=$HOME/.go

WORKDIR $HOME/workspace

RUN nvim --headless "+Lazy! sync" +qa

ENTRYPOINT ["/bin/bash", "-c", "nvim"]
