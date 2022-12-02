--=====================================================================
--
-- status.lua -
--
-- Created by liubang on 2022/02/24 20:57
-- Last Modified: 2022/12/02 20:28
--
--=====================================================================

local ok, _ = pcall(require, 'nvim-web-devicons')
if not ok then
  require('packer').loader 'nvim-web-devicons'
end

ok, _ = pcall(require, 'nvim-navic')
if not ok then
  require('packer').loader 'nvim-navic'
end

local lualine = require 'lualine'

local lineinfo = function()
  local line = vim.fn.line '.'
  local column = vim.fn.col '.'
  return string.format('%d:%d %s', line, column, '[%p%%]')
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

  local format = i == 1 and '[%d%s]' or '[%.1f%s]'
  return string.format(format, size, suffixes[i])
end

local mode = function()
  return '\u{e7c5} ' .. require('lualine.utils.mode').get_mode()
end

local lsp_names = { --{{{
  ['null-ls'] = 'NLS',
  ['diagnostics_on_open'] = 'Diagnostics',
  ['diagnostics_on_save'] = 'Diagnostics',
  bashls = 'Bash',
  clangd = 'C++',
  dockerls = 'Docker',
  gopls = 'Go',
  html = 'HTML',
  jedi_language_server = 'Python',
  jsonls = 'JSON',
  sqls = 'SQL',
  sumneko_lua = 'Lua',
  tsserver = 'TS',
  vimls = 'Vim',
  yamlls = 'YAML',
  intelephense = 'PHP',
  rust_analyzer = 'Rust',
}
--}}}

local lsp_clients = function()
  local clients = {}
  for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
    local name = lsp_names[client.name] or client.name
    clients[#clients + 1] = name
  end
  return ' ' .. table.concat(clients, ' 珞 ')
end

local is_lsp_attached = function() --{{{
  return next(vim.lsp.get_active_clients { bufnr = 0 }) ~= nil
end --}}}

lualine.setup {
  options = {
    icons_enabled = true,
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
      -- '%=', -- center
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
      {
        require('nvim-navic').get_location,
        cond = require('nvim-navic').is_available,
      },
    },
    lualine_x = {
      lineinfo,
      {
        lsp_clients,
        cond = function()
          return is_lsp_attached()
        end,
      },
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

-- vim: foldmethod=marker foldlevel=0
