FROM debian:stable

ENV NVIM_VERSION="v0.8.1"
ENV HOME=/home/neovim

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    apt-transport-https \
    curl \
    npm \
    python3 \
    python3-pip \
    fzf \
    autoconf \
    automake \
    make \
    cmake \
    g++ \
    pkg-config \
    lua5.3 \
    nodejs \
    ripgrep \
    git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupdel users                                              \
  && groupadd -r neovim                                         \
  && useradd --create-home --home-dir $HOME                     \
             -r -g neovim                                       \
             neovim

RUN cd /tmp && \
    curl -sLf https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux64.tar.gz -o nvim-linux64.tar.gz && \
    tar -zxvf nvim-linux64.tar.gz && \
    mkdir -p /opt/app && \
    mv nvim-linux64 /opt/app/nvim && \
    rm nvim-linux64.tar.gz

USER neovim

ENV PYTHON3_HOST_PROG="/usr/bin/python3"
ENV PATH=$PATH:/opt/app/nvim/bin

WORKDIR $HOME

RUN mkdir -p $HOME/.config && \
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        ~/.local/share/nvim/site/pack/packer/opt/packer.nvim && \
    git clone --depth 1  https://github.com/liubang/nvimrc.git $HOME/.config/nvim && \
    pip install --user pynvim

RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' \
    nvim --headless -c 'TSInstall' +"sleep 15" +qa || true

ENTRYPOINT ["/bin/bash", "-c", "nvim"]
