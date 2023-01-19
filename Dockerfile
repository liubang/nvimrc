#======================================================================
#
# Dockerfile -
#
# Created by liubang on 2023/01/18 17:16
# Last Modified: 2023/01/18 17:16
#
#======================================================================


# build neovim
FROM --platform=$TARGETPLATFORM ubuntu:20.04 AS builder

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
ENV NVIM_TAG=0.8.2

RUN apt-get update &&  \
    apt-get install -y \
    autoconf           \
    automake           \
    build-essential    \
    gcc-10             \
    git                \
    cmake              \
    gettext            \
    libtool-bin        \
    locales            \
    ninja-build        \
    pkg-config         \
    unzip

RUN mkdir -p /opt/app &&                                                                                       \
    cd /tmp &&                                                                                                 \
    curl -sLf https://github.com/neovim/neovim/archive/refs/tags/v$NVIM_TAG.tar.gz -o nvim.$NVIM_TAG.tar.gz && \
    tar -zxvf nvim.$NVIM_TAG.tar.gz &&                                                                         \
    cd neovim-$NVIM_TAG &&                                                                                     \
    CC=gcc-10 make CMAKE_BUILD_TYPE="Release" CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX:PATH=" &&              \
    make DESTDIR="/opt/app/nvim" install


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
    pip install --user pynvim &&                                                     \
    go env -w GO111MODULE=on &&                                                      \
    go env -w GOPATH=$HOME/.go &&                                                    \
    nvim --headless +'Lazy! sync' +qa

WORKDIR $HOME/workspace

ENTRYPOINT ["/bin/bash", "-c", "nvim"]
