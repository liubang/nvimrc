-- https://github.com/glepnir/galaxyline.nvim/blob/main/example/eviline.lua
local gl = require('galaxyline')
local gls = gl.section
local vcs = require('galaxyline.provider_vcs')

-- for string:split function
require('lb.utils.string')

gl.short_line_list = require('lb.utils.buffer').list_special_buffers()

-- LuaFormatter off
local colors = {
  bg       = '#3c3836',
  bg_gray  = '#32302f',
  line_bg  = '#665c54',
  fg       = '#8FBCBB',
  fg_green = '#65a380',
  yellow   = '#fabd2f',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#afd700',
  orange   = '#FF8800',
  purple   = '#5d4d7a',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}
-- auto change color according the vim mode
local alias = {
  n = 'NORMAL',
  i = 'INSERT',
  c = 'COMMAND',
  v = 'VISUAL',
  V = 'VISUAL',
  ['\22'] = 'VISUAL',
  t = 'TERMINAL',
  s = 'SELECT',
  S = 'SELECT',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
}
local mode_color = {
  n = colors.magenta,
  i = colors.green,
  c = colors.red,
  v = colors.blue,
  V = colors.blue,
  ['\22'] = colors.blue,
  s = colors.orange,
  S = colors.orange,
  t = colors.purple,
  ['r?'] = colors.purple,
  ['!'] = colors.purple,
}
-- LuaFormatter on

local buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

gls.left[1] = {
  ViMode = {
    provider = function()
      local mode = vim.fn.mode()
      if mode_color[mode] ~= nil then
        vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_color[mode])
        return '  ' .. alias[mode]
      else
        vim.api.nvim_command('hi GalaxyViMode guibg=' .. colors.red)
        return '  UNKNOWN'
      end
    end,
    highlight = {colors.bg_gray, colors.line_bg, 'bold'},
  },
}

gls.left[2] = {
  LeftDelimiter = {
    provider = function()
      local mode = vim.fn.mode()
      if mode_color[mode] ~= nil then
        vim.api
          .nvim_command('hi GalaxyLeftDelimiter guifg=' .. mode_color[mode])
      else
        vim.api.nvim_command('hi GalaxyLeftDelimiter guifg=' .. colors.red)
      end
      return '\u{e0b8} '
    end,
    highlight = {colors.orange, colors.line_bg, 'bold'},
  },
}

gls.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      colors.line_bg,
    },
  },
}

gls.left[4] = {
  FileName = {
    provider = function()
      return require('galaxyline.provider_fileinfo').get_current_file_name()
    end,
    condition = buffer_not_empty,
    highlight = {colors.fg, colors.line_bg, 'bold'},
  },
}

gls.left[5] = {
  FileSize = {
    provider = function()
      local filepath = vim.fn.expand('%:p')
      local size = require('lb.utils.fs').file_size(filepath)
      return ' \u{e0b9} ' .. size .. ' '
    end,
    condition = buffer_not_empty,
    highlight = {colors.fg, colors.line_bg, 'bold'},
  },
}

gls.left[6] = {
  GitBranchSep = {
    provider = function()
      return '\u{e0b9} '
    end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.fg, colors.line_bg},
  },
}

gls.left[7] = {
  GitIcon = {
    provider = function()
      return string.format('  %s ', vcs.get_git_branch())
    end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.orange, colors.line_bg, 'bold'},
  },
}

gls.left[8] = {
  LeftEnd = {
    provider = function()
      return '\u{e0b8}'
    end,
    highlight = {colors.line_bg, colors.bg},
  },
}

gls.left[9] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '   ',
    highlight = {colors.red, colors.bg},
  },
}

gls.left[10] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '   ',
    highlight = {colors.blue, colors.bg},
  },
}

gls.right[1] = {
  RightDelimiter = {
    provider = function()
      return '\u{e0be}'
    end,
    highlight = {colors.line_bg, colors.bg},
  },
}

gls.right[2] = {
  FileFormat = {
    provider = function()
      if vim.bo.fenc ~= '' then
        return string.format('  %s [%s]', vim.bo.fileformat, vim.bo.fenc)
      else
        return string.format('  %s [%s]', vim.bo.fileformat, vim.o.enc)
      end
    end,
    highlight = {colors.fg, colors.line_bg, 'bold'},
  },
}

gls.right[3] = {
  RightLastDelimiter = {
    provider = function()
      local mode = vim.fn.mode()
      if mode_color[mode] ~= nil then
        vim.api.nvim_command('hi GalaxyRightLastDelimiter guibg=' ..
                               mode_color[mode])
      else
        vim.api.nvim_command('hi GalaxyRightLastDelimiter guibg=' .. colors.red)
      end
      return '\u{e0b8}'
    end,
    highlight = {colors.line_bg, colors.bg, 'bold'},
  },
}

gls.right[4] = {
  LineInfo = {
    provider = function()
      local mode = vim.fn.mode()
      if mode_color[mode] ~= nil then
        vim.api.nvim_command('hi GalaxyLineInfo guibg=' .. mode_color[mode])
      else
        vim.api.nvim_command('hi GalaxyLineInfo guibg=' .. colors.red)
      end
      local c = vim.fn.line('.')
      local e = vim.fn.line('$')
      local o = vim.fn.col('.')
      return string.format('  %d%s  %d:%d ', (c * 100 / e), '%', e, o)
    end,
    highlight = {colors.bg_gray, colors.line_bg, 'bold'},
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = function()
      return string.format('  %s ', vim.bo.filetype:upper())
    end,
    separator = '\u{e0b8}',
    separator_highlight = {colors.line_bg, colors.bg},
    highlight = {colors.fg, colors.line_bg},
  },
}

-- LuaFormatter off
local buf_icon = {
  help                = '   ',
  defx                = '   ',
  nerdtree            = '   ',
  denite              = '   ',
  ['vim-plug']        = '   ',
  SpaceVimPlugManager = '   ',
  qf                  = '   ',
  vista               = ' 識 ',
  vista_kind          = '   ',
  dbui                = '   ',
  magit               = '   ',
  NvimTree            = '   ',
}
-- LuaFormatter on

gls.short_line_right[1] = {
  BufferIcon = {
    provider = function()
      local bi = buf_icon[vim.bo.filetype]
      if bi ~= nil then
        return bi
      end
      local f_name, f_extension = vim.fn.expand('%:t'), vim.fn.expand('%:e')
      if f_name == '' or f_extension == '' then
        return '   '
      end
      local icon = require('nvim-web-devicons').get_icon(f_name, f_extension)
      if icon == nil then
        icon = '   '
      end
      return string.format(' %s ', icon)
    end,
    separator = '\u{e0be}',
    separator_highlight = {colors.line_bg, colors.bg},
    highlight = {colors.fg, colors.line_bg},
  },
}
