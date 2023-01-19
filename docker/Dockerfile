#======================================================================
#
# Dockerfile -
#
# Created by liubang on 2023/01/18 17:16
# Last Modified: 2023/01/18 17:16
#
#======================================================================

FROM --platform=$TARGETPLATFORM liubang/neovim:latest AS builder
FROM --platform=$TARGETPLATFORM ubuntu:latest

ARG BUILDARCH

RUN apt update &&                          \
    apt install --no-install-recommends -y \
    curl                                   \
    git                                    \
    npm                                    \
    python3                                \
    python3-pip                            \
    autoconf                               \
    automake                               \
    make                                   \
    cmake                                  \
    gcc                                    \
    g++                                    \
    pkg-config                             \
    unzip                                  \
    lua5.3                                 \
    nodejs                                 \
    ripgrep                                \
    golang-go &&                           \
    apt clean &&                           \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/app
COPY --from=builder /opt/app/nvim /opt/app/nvim

ENV HOME=/home/neovim

RUN groupdel users                                              \
  && groupadd -r neovim                                         \
  && useradd --create-home --home-dir $HOME                     \
             -r -g neovim                                       \
             neovim

USER neovim
ENV PYTHON3_HOST_PROG="/usr/bin/python3"
ENV PATH=/opt/app/nvim/bin:$PATH

RUN mkdir -p $HOME/.config &&                                                        \
    mkdir -p $HOME/workspace &&                                                      \
    cd $HOME &&                                                                      \
    git clone --depth 1  https://github.com/liubang/nvimrc.git $HOME/.config/nvim && \
    rm -rf $HOME/.config/nvim/.github &&                                             \
    rm -rf $HOME/.config/nvim/.git &&                                                \
    rm -rf $HOME/.config/nvim/static &&                                              \
    rm -rf $HOME/.config/nvim/scratch &&                                             \
    rm -rf $HOME/.config/nvim/docker &&                                              \
    pip install --user pynvim &&                                                     \
    go env -w GO111MODULE=on &&                                                      \
    go env -w GOPATH=$HOME/.go &&                                                    \
    nvim --headless +'Lazy! sync' +qa

WORKDIR $HOME/workspace

ENTRYPOINT ["/bin/bash", "-c", "nvim"]
