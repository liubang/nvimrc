FROM python:3.7.5-buster

RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster main contrib non-free" > /etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian/ buster-backports main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security buster/updates main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update                                               \
    && apt-get install -y                                           \
        autoconf                                                    \
        automake                                                    \
        cmake                                                       \
        fish                                                        \
        g++                                                         \
        gettext                                                     \
        git                                                         \
        libtool                                                     \
        libtool-bin                                                 \
        lua5.3                                                      \
        ninja-build                                                 \
        pkg-config                                                  \
        unzip                                                       \
        xclip                                                       \
        xfonts-utils                                                \
        apt-transport-https                                         \
        silversearcher-ag                                           \
        build-essential                                             \ 
        clang                                                       \
        libclang-dev                                                \
        llvm-dev                                                    \
        rapidjson-dev                                               \
        shellcheck

RUN pip install --user neovim pipenv

RUN cd /tmp \
    && mkdir /opt/app \
    && wget https://github.com/neovim/neovim/releases/download/v0.4.3/nvim-linux64.tar.gz \
    && tar -zxvf nvim-linux64.tar.gz \
    && mv nvim-linux64 /opt/app/nvim \
    && rm -r nvim-linux64.tar.gz

RUN cd /tmp/ \
    && wget https://nodejs.org/dist/v12.13.0/node-v12.13.0-linux-x64.tar.xz \
    && tar -xvf node-v12.13.0-linux-x64.tar.xz \
    && mv node-v12.13.0-linux-x64 /opt/app/node \
    && rm -r /tmp/node-v12.13.0-linux-x64.tar.xz

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install --no-install-recommends yarn -y \
    && apt-get clean all

RUN cd /tmp \
    && wget https://dl.google.com/go/go1.13.4.linux-amd64.tar.gz \
    && tar -zxvf go1.13.4.linux-amd64.tar.gz \
    && mv go /opt/app/go \
    && rm -r go1.13.4.linux-amd64.tar.gz 

RUN cd /tmp \
    && git clone --depth=1 --recursive https://github.com/MaskRay/ccls  \
    && cd ccls \
    && cmake -H. -BRelease \
    && cmake --build Release \
    && mv Release/ccls /usr/bin \
    && chmod a+x /usr/bin/ccls \
    && cd /tmp \ 
    && rm -rf ccls
    
ENV PATH=/opt/app/node/bin:/opt/app/nvim/bin:/opt/app/go/bin:$PATH

RUN npm config set registry https://mirrors.huaweicloud.com/repository/npm/ \
    && npm cache clean -f \
    && npm config set disturl https://mirrors.huaweicloud.com/nodejs \
    && npm install -g bash-language-server \
    && npm install -g dockerfile-language-server-nodejs \
    && go env -w GOPROXY=https://goproxy.cn,direct

RUN git clone https://github.com/iliubang/vimrc.git ~/.vim \
    && ln -s ~/.vim ~/.config/nvim  \
    && echo "OK"

ENTRYPOINT /opt/app/nvim/bin/nvim
