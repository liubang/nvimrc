-- =====================================================================
--
-- globals.lua - 
--
-- Created by liubang on 2021/05/30 01:05
-- Last Modified: 2021/05/30 01:05
--
-- =====================================================================
local g = vim.g
local python_host_prog = os.getenv('PYTHON_HOST_PROG')
local python3_host_prog = os.getenv('PYTHON3_HOST_PROG')

if python_host_prog ~= nil then
  g.python_host_prog = python_host_prog
end
if python3_host_prog ~= nil then
  g.python3_host_prog = python3_host_prog
end
-- use space as leader key
g.mapleader = ' '
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
