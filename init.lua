--=====================================================================
--
-- init.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:22
--
--=====================================================================

vim.g.nvg_version = 'v3.0'
vim.g.nvg_root = string.gsub(debug.getinfo(1).source, "^@(.+/)[^/]+$", "%1")

require('lb')
