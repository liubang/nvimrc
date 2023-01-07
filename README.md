<h1 align="center">My Neovim Configuration</h1>

<div align="center"><p>
    <a href="https://github.com/neovim/neovim">
        <img src="https://img.shields.io/badge/Neovim-0.8.2-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white" alt="Neovim"/>
    </a>
    <a href="https://github.com/liubang/nvimrc/actions">
        <img src="https://img.shields.io/github/actions/workflow/status/liubang/nvimrc/ci.yaml?style=flat-square&branch=main" alt="Build" />
    </a>
    <a href="#">
        <img src="https://img.shields.io/badge/platform-linux%20macOS-blue?style=flat-square" alt="Platform"/>
    </a>
    <a href="https://github.com/liubang/nvimrc/pulse">
        <img src="https://img.shields.io/github/last-commit/liubang/nvimrc?style=flat-square" alt="Last commit"/>
    </a>
    <a href="https://github.com/liubang/nvimrc/releases">
        <img src="https://img.shields.io/github/v/release/liubang/nvimrc?style=flat-square" alt="Release" />
    </a>
    <a href="https://github.com/liubang/nvimrc/blob/main/LICENSE">
        <img src="https://img.shields.io/github/license/liubang/nvimrc?style=flat-square&logo=MIT&label=License" alt="License"/>
    </a>
</p></div>

![nvim](./static/1.png)

![nvim](./static/2.png)

## Features

- Fast. Less than **30ms** to start (Depends on SSD and CPU, tested on Intel NUC11BTMi9).
- Simple. Run out of the box.
- Modern. Pure lua to config.
- Powerful. Full functionality to code.

![nvim](./static/3.png)

(Tested with [rhysd/vim-startuptime](https://github.com/rhysd/vim-startuptime))

## Requirements

- Neovim >= **0.8.2** (needs to be built with **LuaJIT**)
- Git >= **2.19.0** (for partial clones support)
- a [Nerd Font](https://www.nerdfonts.com/) **_(optional)_**

## Try out

If you have [Docker](https://www.docker.com/) on your system you can try out this config via docker

### Just start nvim

```bash
docker run -it --rm liubang/nvim
```

### Mount a local directory and start nvim

```bash
docker run -it --rm -v $(pwd):/home/neovim/workspace liubang/nvim
```
