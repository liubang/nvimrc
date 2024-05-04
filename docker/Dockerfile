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
