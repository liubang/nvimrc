--=====================================================================
--
-- status.lua -
--
-- Created by liubang on 2022/02/24 20:57
-- Last Modified: 2022/02/24 20:57
--
--=====================================================================
local gps = require 'nvim-gps'

local line_column = function()
  local line = vim.fn.line '.'
  local column = vim.fn.col '.'
  return string.format('\u{e0a1} %d:%d', line, column)
end

local current_line_percent = function()
  return '[%p%%]'
end

local mode = function()
  return '\u{e7c5} ' .. require('lualine.utils.mode').get_mode()
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
  local sufixes = { 'B', 'K', 'M', 'G' }
  local i = 1
  while size > 1024 and i < #sufixes do
    size = size / 1024
    i = i + 1
  end
  return string.format('%.1f%s', size, sufixes[i])
end

require('lualine').setup {
  options = {
    theme = 'gruvbox-material',
    component_separators = '',
    section_separators = '',
    always_divide_middle = true,
    disabled_filetypes = { 'NvimTree', 'Outline' },
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
          readonly = ' \u{e0a2}',
          unnamed = '[No Name]',
        },
      },
      { filesize },
      { gps.get_location, cond = gps.is_available },
    },
    lualine_x = {
      { line_column },
      { current_line_percent },
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

require('fidget').setup {
  text = {
    spinner = 'moon',
  },
  align = {
    bottom = true,
  },
  window = {
    relative = 'editor',
  },
}
