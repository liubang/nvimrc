-- =====================================================================
--
-- dashboard-nvim.lua -
--
-- Created by liubang on 2021/04/19 11:15
-- Last Modified: 2021/04/19 11:15
--
-- =====================================================================

local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

-- set header
dashboard.section.header.opts.hl = 'Keyword'
dashboard.section.header.val = {
  '                                                          ',
  ' ██▓     ██▓ █    ██  ▄▄▄▄    ▄▄▄       ███▄    █   ▄████',
  '▓██▒    ▓██▒ ██  ▓██▒▓█████▄ ▒████▄     ██ ▀█   █  ██▒ ▀█▒',
  '▒██░    ▒██▒▓██  ▒██░▒██▒ ▄██▒██  ▀█▄  ▓██  ▀█ ██▒▒██░▄▄▄░',
  '▒██░    ░██░▓▓█  ░██░▒██░█▀  ░██▄▄▄▄██ ▓██▒  ▐▌██▒░▓█  ██▓',
  '░██████▒░██░▒▒█████▓ ░▓█  ▀█▓ ▓█   ▓██▒▒██░   ▓██░░▒▓███▀▒',
  '░ ▒░▓  ░░▓  ░▒▓▒ ▒ ▒ ░▒▓███▀▒ ▒▒   ▓▒█░░ ▒░   ▒ ▒  ░▒   ▒ ',
  '░ ░ ▒  ░ ▒ ░░░▒░ ░ ░ ▒░▒   ░   ▒   ▒▒ ░░ ░░   ░ ▒░  ░   ░ ',
  '  ░ ░    ▒ ░ ░░░ ░ ░  ░    ░   ░   ▒      ░   ░ ░ ░ ░   ░ ',
  '    ░  ░ ░     ░      ░            ░  ░         ░       ░ ',
  '                           ░                              ',
  '                                                          ',
  '                                                          ',
}

-- Set menu
local button_opts = { hl_shortcut = 'Keyword' }
dashboard.section.buttons.val = {
  dashboard.button(
    'SPC ff',
    '  > Find file',
    [[:lua require('telescope.builtin').find_files({previewer = false})<CR>]]
  ),
  dashboard.button(
    'SPC bb',
    '  > List buffers',
    [[:lua require('telescope.builtin').buffers({previewer = false})<CR>]]
  ),
  dashboard.button(
    'SPC ag',
    ' > Find word',
    [[:lua require('telescope.builtin').live_grep()<CR>]]
  ),
  dashboard.button(
    'SPC wo',
    '  > List projects',
    [[:lua require('telescope').extensions.project.project({change_dir = true})<CR>]]
  ),
  dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
  dashboard.button('q', '  > Quit NVIM', ':qa<CR>'),
}

local function footer()
  local plugins = #vim.tbl_keys(packer_plugins)
  local v = vim.version()
  return string.format(' %s   v%s.%s.%s', plugins, v.major, v.minor, v.patch)
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = dashboard.section.header.opts.hl
dashboard.config.layout[1].val = 1

alpha.setup(dashboard.config)
