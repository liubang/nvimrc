#======================================================================
#
# build_neovim.Dockerfile -
#
# Created by liubang on 2023/01/19 15:45
# Last Modified: 2023/01/19 15:45
#
#======================================================================

# syntax=docker/dockerfile:1
# build neovim
FROM --platform=$TARGETPLATFORM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
ARG NVIM_TAG

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
