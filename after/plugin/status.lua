--=====================================================================
--
-- status.lua -
--
-- Created by liubang on 2022/02/24 20:57
-- Last Modified: 2022/02/24 20:57
--
--=====================================================================
local navic = require 'nvim-navic'
local lualine = require 'lualine'
local fidget = require 'fidget'

local lineinfo = function()
  local line = vim.fn.line '.'
  local column = vim.fn.col '.'
  return string.format('\u{e0a1} %d:%d %s', line, column, '[%p%%]')
end

local filesize = function()
  local file = vim.fn.expand '%:p'
  if file == nil or #file == 0 then
    return ''
  end
  local size = vim.fn.getfsize(file)
  if size <= 0 then
    return ''
  end

  local suffixes = { 'B', 'KB', 'MB', 'GB' }

  local i = 1
  while size > 1024 and i < #suffixes do
    size = size / 1024
    i = i + 1
  end

  local format = i == 1 and '%d%s' or '%.1f%s'
  return string.format(format, size, suffixes[i])
end

local mode = function()
  return '\u{e7c5} ' .. require('lualine.utils.mode').get_mode()
end

local lspprovider = function()
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return ''
  end
  local cm = {}
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      cm[client.name] = client.name
    end
  end
  local cs = {}
  for key, _ in pairs(cm) do
    table.insert(cs, key)
  end
  if #cs > 0 then
    return '\u{f817} ' .. table.concat(cs, ',')
  end
  return ''
end

lualine.setup {
  options = {
    theme = 'gruvbox-material',
    component_separators = '',
    section_separators = '',
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = { mode },
    lualine_b = {
      { 'branch', icon = '\u{e725}' },
      { 'diff' },
      { 'diagnostics', colored = true },
    },
    lualine_c = {
      {
        'filename',
        path = 1,
        file_status = true,
        shorting_target = 40,
        symbols = {
          modified = ' \u{f040}',
          readonly = ' \u{f023}',
          unnamed = '[No Name]',
        },
      },
      { filesize },
      { navic.get_location, cond = navic.is_available },
    },
    lualine_x = {
      lineinfo,
      lspprovider,
    },
    lualine_y = {
      { 'filetype', icon_only = true, colored = true },
      { 'encoding' },
    },
    lualine_z = {
      {
        'fileformat',
        icons_enabled = true,
        symbols = {
          unix = ' UNIX',
          dos = ' WIN',
          mac = ' OSX',
        },
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
}

fidget.setup {
  text = {
    spinner = 'dots',
    done = '',
  },
  align = {
    bottom = true,
    right = true,
  },
  window = {
    relative = 'win',
    blend = 100,
    zindex = nil,
  },
}
