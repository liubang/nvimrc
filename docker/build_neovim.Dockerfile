# Copyright (c) 2024 The Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Authors: liubang (it.liubang@gmail.com)

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
