local gps = require 'nvim-gps'

local line_column = function()
  local line = vim.fn.line '.'
  local column = vim.fn.col '.'
  return string.format('\u{e0a1} %d:%d', line, column)
end

local current_line_percent = function()
  return '[%p%%]'
end

require('lualine').setup {
  options = {
    theme = 'gruvbox-material',
    component_separators = '',
    section_separators = '',
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', icon = '\u{e725}' },
      { 'diff' },
      { 'diagnostics', colored = true },
    },
    lualine_c = {
      { 'filename', file_status = true, shorting_target = 40, path = 1 },
      { gps.get_location, cond = gps.is_available },
    },
    lualine_x = { { line_column }, { current_line_percent } },
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
