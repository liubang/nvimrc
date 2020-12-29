-- =====================================================================
--
-- vim-startify.lua - 
--
-- Created by liubang on 2020/12/12 21:35
-- Last Modified: 2020/12/12 21:35
--
-- =====================================================================
local g = vim.g
local version = require('lb.utils.version')

local header_common = {
  '                                                ',
  '        Author: liubang <it.liubang@gmail.com>  ',
  '          Site: https://iliubang.cn             ',
  '       Version: ' .. g.nvg_version .. '         ',
  '       Neovim : ' .. version.nvim_version() .. ' ',
}

local header_cres = {
  '       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
  '       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
  '       ⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠀⠀ ',
  '       ⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⠀⠀⠀⠀⠀ ',
  '       ⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀ ',
  '       ⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀ ',
  '       ⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀ ',
  '       ⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀⠀ ',
  '       ⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄⠀ ',
  '       ⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿⠀ ',
  '       ⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸⠀ ',
  '       ⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈⠀ ',
  '       ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
  '       ⠀⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀ ',
  '       ⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀ ',
}

local header_superman = {
  '        ▄▄▄▄▄███████████████████▄▄▄▄▄     ',
  '      ▄██████████▀▀▀▀▀▀▀▀▀▀██████▀████▄   ',
  '     █▀████████▄             ▀▀████ ▀██▄  ',
  '    █▄▄██████████████████▄▄▄         ▄██▀ ',
  '     ▀█████████████████████████▄    ▄██▀  ',
  '       ▀████▀▀▀▀▀▀▀▀▀▀▀▀█████████▄▄██▀    ',
  '         ▀███▄              ▀██████▀      ',
  '           ▀██████▄        ▄████▀         ',
  '              ▀█████▄▄▄▄▄▄▄███▀           ',
  '                ▀████▀▀▀████▀             ',
  '                  ▀███▄███▀                ',
  '                     ▀█▀                   ',
}

local total_plugins = 0
if vim.fn.exists('*dein#get') then
  local plugins = vim.fn['dein#get']()
  for _, _ in pairs(plugins) do
    total_plugins = total_plugins + 1
  end
end

g.webdevicons_enable_startify = 1
g.startify_files_number = 8
g.startify_enable_special = 0
local header = {}
for _, line in pairs(header_superman) do
  table.insert(header, line)
end
for _, line in pairs(header_common) do
  table.insert(header, line)
end
g.startify_custom_header = header
g.startify_lists = {{type = 'files', header = {'    MRU'}}}
g.startify_custom_footer = {'', '    neovim loaded ' .. total_plugins .. ' plugins.', ''}

vim.cmd [[autocmd User Startified setlocal buflisted]]
