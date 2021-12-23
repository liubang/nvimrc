local gl = require 'galaxyline'
local gls = gl.section
local condition = require 'galaxyline.condition'
local vcs = require 'galaxyline.provider_vcs'
local buffer = require 'galaxyline.provider_buffer'
local fileinfo = require 'galaxyline.provider_fileinfo'
local diagnostic = require 'galaxyline.provider_diagnostic'
local lspclient = require 'galaxyline.provider_lsp'
local icons = require('galaxyline.provider_fileinfo').define_file_icon()
local gps = require 'nvim-gps'

local colors = {
  black = '#282828',
  bblack = '#928374',
  red = '#cc241d',
  bred = '#fb4934',
  green = '#98971a',
  bgreen = '#b8bb26',
  yellow = '#d79921',
  byellow = '#fabd2f',
  blue = '#458588',
  bblue = '#83a598',
  mangenta = '#b16286',
  bmangenta = '#d3869b',
  cyan = '#689d6a',
  bcyan = '#8ec07c',
  white = '#a89984',
  bwhite = '#ebdbb2',
}

icons['man'] = { colors.green, '\u{f128}' }

-- rewrite some function
local line_column = function()
  local line = vim.fn.line '.'
  local column = vim.fn.col '.'
  return string.format('%d:%d ', line, column)
end

local current_line_percent = function()
  local current_line = vim.fn.line '.'
  local total_line = vim.fn.line '$'
  local result, _ = math.modf((current_line / total_line) * 100)
  return result .. '%'
end

gls.left = {
  {
    Mode = {
      provider = function()
        local alias = {
          n = 'NORMAL',
          i = 'INSERT',
          c = 'COMMAND',
          v = 'VISUAL',
          V = 'VISUAL',
          [''] = 'VISUAL',
        }
        if not condition.hide_in_width() then
          alias = { n = 'N', i = 'I', c = 'C', v = 'V', V = 'V', [''] = 'V' }
        end
        return string.format('  \u{e7c5} %s ', alias[vim.fn.mode()])
      end,
      highlight = { colors.black, colors.yellow, 'bold' },
    },
  },
  {
    GitIcon = {
      provider = function()
        return '  \u{e725} '
      end,
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      highlight = { colors.black, colors.bblack },
    },
  },
  {
    GitBranch = {
      provider = function()
        return string.format('%s ', vcs.get_git_branch())
      end,
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      highlight = { colors.black, colors.bblack },
    },
  },
  {
    DiffAdd = {
      provider = vcs.diff_add,
      icon = '+',
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      highlight = { colors.black, colors.bblack },
    },
  },
  {
    DiffModified = {
      provider = vcs.diff_modified,
      icon = '~',
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      highlight = { colors.black, colors.bblack },
    },
  },
  {
    DiffRemove = {
      provider = vcs.diff_remove,
      icon = '-',
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      highlight = { colors.black, colors.bblack },
    },
  },
  {
    BlankSpace = {
      provider = function()
        return ' '
      end,
      highlight = { colors.black, colors.black },
    },
  },
  {
    FileIcon = {
      provider = fileinfo.get_file_icon,
      condition = condition.buffer_not_empty,
      highlight = { fileinfo.get_file_icon_color, colors.black },
    },
  },
  {
    FileName = {
      provider = function()
        local filepath = vim.fn.expand '%:p'
        return string.format(
          '%s | %s ',
          require('lb.utils.fs').file_size(filepath),
          fileinfo.get_current_file_name()
        )
      end,
      condition = condition.buffer_not_empty,
      highlight = { colors.white, colors.black },
    },
  },
  {
    Blank = {
      provider = function()
        return ''
      end,
      highlight = { colors.white, colors.black },
    },
  },
  {
    nvimGPS = {
      provider = function()
        return gps.get_location()
      end,
      condition = function()
        return gps.is_available()
      end,
      highlight = { colors.white, colors.black },
    },
  },
}

gls.right = {
  {
    DiagnosticError = {
      provider = diagnostic.get_diagnostic_error,
      icon = ' \u{f057} ',
      condition = function()
        return condition.check_active_lsp() and condition.hide_in_width()
      end,
      highlight = { colors.red, colors.black },
    },
  },
  {
    DiagnosticWarn = {
      provider = diagnostic.get_diagnostic_warn,
      icon = ' \u{f071} ',
      condition = function()
        return condition.check_active_lsp() and condition.hide_in_width()
      end,
      highlight = { colors.yellow, colors.black },
    },
  },
  {
    DiagnosticHint = {
      provider = diagnostic.get_diagnostic_hint,
      icon = ' \u{f41b} ',
      condition = function()
        return condition.check_active_lsp() and condition.hide_in_width()
      end,
      highlight = { colors.cyan, colors.black },
    },
  },
  {
    DiagnosticInfo = {
      provider = diagnostic.get_diagnostic_info,
      icon = ' \u{f05a} ',
      condition = function()
        return condition.check_active_lsp() and condition.hide_in_width()
      end,
      highlight = { colors.cyan, colors.black },
    },
  },
  {
    LineInfo = {
      provider = function()
        return string.format('  \u{e0a1} %s[%s] ', line_column(), current_line_percent())
      end,
      highlight = { colors.white, colors.black },
      -- highlight = { colors.black, colors.yellow },
    },
  },
  {
    LspStatus = {
      provider = function()
        return string.format(' %s ', lspclient.get_lsp_client())
      end,
      icon = '  \u{f817} ',
      condition = function()
        return condition.check_active_lsp() and condition.hide_in_width()
      end,
      highlight = { colors.white, colors.black },
    },
  },
  {
    FileType = {
      provider = function()
        return string.format('  %s ', buffer.get_buffer_filetype())
      end,
      condition = function()
        return buffer.get_buffer_filetype() ~= ''
      end,
      highlight = { colors.black, colors.white },
    },
  },
  {
    FileFormat = {
      provider = function()
        if vim.fn.has 'mac' == 1 then
          return string.format('  \u{f302} %s ', fileinfo.get_file_format())
        elseif vim.fn.has 'unix' == 1 then
          return string.format('  \u{f17c} %s ', fileinfo.get_file_format())
        else
          return string.format('  \u{f17a} %s ', fileinfo.get_file_format())
        end
      end,
      condition = condition.hide_in_width,
      highlight = { colors.black, colors.bblack },
    },
  },
  {
    FileEncode = {
      provider = function()
        return string.format('  \u{f040}%s ', fileinfo.get_file_encode())
      end,
      condition = condition.hide_in_width,
      highlight = { colors.black, colors.yellow },
    },
  },
}

-- short line
gl.short_line_list = require('lb.utils.buffer').list_special_buffers()

table.insert(gls.short_line_left, {
  BufferIcon = {
    provider = function()
      local icon = buffer.get_buffer_type_icon()
      if icon ~= nil then
        return string.format(' %s ', icon)
      end
    end,
    highlight = { colors.white, colors.black },
  },
})

table.insert(gls.short_line_left, {
  BufferName = {
    provider = function()
      if vim.fn.index(gl.short_line_list, vim.bo.filetype) ~= -1 then
        local filetype = vim.bo.filetype
        if filetype == 'NvimTree' then
          return ' Explorer '
        elseif filetype == 'vista_kind' then
          return ' Outline '
        end
      else
        if fileinfo.get_current_file_name() ~= '' then
          return string.format(
            '  %s %s | %s ',
            fileinfo.get_file_icon(),
            fileinfo.get_file_size(),
            fileinfo.get_current_file_name()
          )
        end
      end
    end,
    separator = '',
    highlight = { colors.white, colors.black },
  },
})
