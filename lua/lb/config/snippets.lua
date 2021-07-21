-- =====================================================================
--
-- snippets.lua - 
--
-- Created by liubang on 2021/02/06 00:06
-- Last Modified: 2021/02/06 00:06
--
-- =====================================================================
local snippets = require('snippets')
local U = require('snippets.utils')

-- about vsnip
vim.g.vsnip_snippet_dir = vim.g.snip_path

-- about snippets
snippets.snippets = {
  _global = {
    todo = 'TODO(liubang): ',
    date = [[${=os.date("%Y-%m-%d")}]],
    datetime = [[${=os.date("%Y-%m-%d %H:%M:%S")}]],
  },
  php = {php = '<?php\n'},
  lua = {formatoff = '-- LuaFormatter off', formaton = '-- LuaFormatter on'},
  cpp = {
    formatoff = '// clang-format off', 
    formaton = '// clang-format on',
    vim = [[/* vim: set expandtab ts=4 sw=4 sts=4 tw=100: */]]
  },
  c = {
    formatoff = '// clang-format off', 
    formaton = '// clang-format on',
    vim = [[/* vim: set expandtab ts=4 sw=4 sts=4 tw=100: */]]
  },
}
