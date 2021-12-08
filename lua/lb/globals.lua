-- =====================================================================
--
-- globals.lua -
--
-- Created by liubang on 2021/05/30 01:05
-- Last Modified: 2021/05/30 01:05
--
-- =====================================================================
local python_host_prog = os.getenv 'PYTHON_HOST_PROG'
local python3_host_prog = os.getenv 'PYTHON3_HOST_PROG'

if python_host_prog ~= nil then
  vim.g.python_host_prog = python_host_prog
end
if python3_host_prog ~= nil then
  vim.g.python3_host_prog = python3_host_prog
end

vim.g.loaded_matchparen = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- global functions
_G.P = function(v)
  print(vim.inspect(v))
  return v
end
-- _G.folds_render = require('lb.utils.folds').render
