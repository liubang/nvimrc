--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2023/09/07 00:19
-- Last Modified: 2023/09/07 00:19
--
--=====================================================================
vim.filetype.add { -- {{{
    filename = {
        ['.clangd'] = 'yaml',
        ['.clang-format'] = 'yaml',
        ['.bazelrc'] = 'bzl',
        ['.gitignore'] = 'gitconfig',
        ['go.sum'] = 'gosum',
        ['go.mod'] = 'gomod',
        ['BUILD'] = 'bzl',
        ['BCLOUD'] = 'bzl',
        ['WORKSPACE'] = 'bzl',
    },
    extension = {
        thrift = 'thrift',
        wiki = 'markdown',
    },
    pattern = {
        ['*.log'] = 'log',
        ['*_LOG'] = 'log',
    },
} -- }}}
