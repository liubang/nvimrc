# Changelog

## [3.8.0](https://github.com/liubang/nvimrc/compare/v3.7.3...v3.8.0) (2023-02-04)


### Features

* **ci:** upgrade neovim to 0.8.3 ([8f955d6](https://github.com/liubang/nvimrc/commit/8f955d6f98bc10577af7717928283f8d42aac39e))


### Bug Fixes

* **markdown-preview:** fix enabled function ([58c9841](https://github.com/liubang/nvimrc/commit/58c9841c56bad45b0c9cfd2c606a90b39fe92d3f))
* **nvim-tree:** deprecate open_on_setup.* options ([9839012](https://github.com/liubang/nvimrc/commit/983901269da434b55694ebf1fc32e4d71184a52c))


### Performance Improvements

* **markdown-preview:** add peek.nvim ([a4f1fa6](https://github.com/liubang/nvimrc/commit/a4f1fa6446547dd8984287c2f6a45f5f11a9755f))
* **plugins:** upgrade plugins ([491ad47](https://github.com/liubang/nvimrc/commit/491ad47129e25abff588877536f833032078f530))

## [3.7.3](https://github.com/liubang/nvimrc/compare/v3.7.2...v3.7.3) (2023-01-25)


### Performance Improvements

* **hop:** update keymaps of hop ([5f19fa4](https://github.com/liubang/nvimrc/commit/5f19fa413d3ffcc8e92a34657e1b025598871397))
* **keymap:** some useful keymaps ([5c0ed9a](https://github.com/liubang/nvimrc/commit/5c0ed9a22e2d34d441ba1852dbcf50016b44a1ab))
* **plugins:** upgrade plugins ([02886db](https://github.com/liubang/nvimrc/commit/02886db7e1ce89bbeb71e20d0368e87288c73180))
* **plugins:** upgrade plugins and some trivial optimizations ([7324bf4](https://github.com/liubang/nvimrc/commit/7324bf4e9f1b1beac7e9a9ee107906db925bf6a5))
* **plugins:** upgrade plugins and some trivial optimizations ([a44daf8](https://github.com/liubang/nvimrc/commit/a44daf84783fee2ca3d464c0c5ce4e060c983ba2))

## [3.7.2](https://github.com/liubang/nvimrc/compare/v3.7.1...v3.7.2) (2023-01-19)


### Bug Fixes

* **ci:** fix build_neovim ([940ff2a](https://github.com/liubang/nvimrc/commit/940ff2a03ed80a6d70337e61e5ab2410af24b45f))


### Performance Improvements

* **docker:** optimize docker image construction process ([21e8782](https://github.com/liubang/nvimrc/commit/21e878268e15a2df0ff336322b367dbcc1c801d8))

## [3.7.1](https://github.com/liubang/nvimrc/compare/v3.7.0...v3.7.1) (2023-01-19)


### Bug Fixes

* **ci:** build multi-architecture docker image ([fc0a319](https://github.com/liubang/nvimrc/commit/fc0a319713149482c62f56de43cbb6047c320248))

## [3.7.0](https://github.com/liubang/nvimrc/compare/v3.6.0...v3.7.0) (2023-01-19)


### Features

* **ci:** build multi-architecture docker image ([7a88bef](https://github.com/liubang/nvimrc/commit/7a88bef4f9cf6257789ca1a5fff13243c224742b))

## [3.6.0](https://github.com/liubang/nvimrc/compare/v3.5.0...v3.6.0) (2023-01-18)


### Features

* **ci:** push docker image with latest tag ([6ef1a8c](https://github.com/liubang/nvimrc/commit/6ef1a8c2184fbbe66da4d1c95197c804f0389cb3))
* **doc:** automatically update readme file ([67c21d4](https://github.com/liubang/nvimrc/commit/67c21d4ebe913842f9de79fd25796eedeeb7a601))
* **doc:** perfect keymap description and generate keymaps section in README.md ([9dd3f9e](https://github.com/liubang/nvimrc/commit/9dd3f9e741c6dd324d0431a568b4a11a31baa17b))
* **keymaps:** use lazy keys to manage plugins keymaps ([c8879b5](https://github.com/liubang/nvimrc/commit/c8879b553be799ebce4a797ec918e3fd5ed60253))
* **plugins:** add neogen ([9d7f94e](https://github.com/liubang/nvimrc/commit/9d7f94e9376ab8b9f2bb624e7bf16376242ae21f))
* **treesitter:** add tsx ([8da93f2](https://github.com/liubang/nvimrc/commit/8da93f2d932168a2fa6b563707084ff46e611524))

## [3.5.0](https://github.com/liubang/nvimrc/compare/v3.4.0...v3.5.0) (2023-01-14)


### Features

* **php:** add lsp formatting keymap for php ([702f9a2](https://github.com/liubang/nvimrc/commit/702f9a27911f57f6f2cac9d57b82654a54c5bb05))


### Bug Fixes

* **bufferline:** load bufferline on VeryLazy event ([d79ff21](https://github.com/liubang/nvimrc/commit/d79ff212f4f05d7c941d07c8f5a38528d12c1b25))


### Performance Improvements

* **neodev:** enable experimental pathStrict setting for better sumneko performance ([4674356](https://github.com/liubang/nvimrc/commit/467435650b3731d35a8572ec4588f1347fa20586))

## [3.4.0](https://github.com/liubang/nvimrc/compare/v3.3.0...v3.4.0) (2023-01-07)


### Features

* **ci:** automatically build Docker image when a new version is released ([e8428ec](https://github.com/liubang/nvimrc/commit/e8428ec7b4c6c8d6505ec0b9b3c9da9dcbcea5f4))

## [3.3.0](https://github.com/liubang/nvimrc/compare/3.2.0...v3.3.0) (2023-01-06)


### Features

* **autocmd:** automatically jump to the last place you’ve visited in a file before exiting ([280dc8f](https://github.com/liubang/nvimrc/commit/280dc8f75bd8d32a9510a05c724a744fc14f20d3))
* **comment:** set rust commentstring ([4ba04bb](https://github.com/liubang/nvimrc/commit/4ba04bbc09686a6c7e116d0eab077561a712df97))
* **lsp:** add vue lsp config ([3b75f34](https://github.com/liubang/nvimrc/commit/3b75f34de6ebf12cdb64ea192baec4f469740716))
* **wilder:** better highlighting ([c3bf420](https://github.com/liubang/nvimrc/commit/c3bf420d198b841cff47e062169fb62317e6840d))
