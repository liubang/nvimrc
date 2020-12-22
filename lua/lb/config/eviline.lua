-- https://github.com/glepnir/galaxyline.nvim/blob/main/example/eviline.lua
local gl = require('galaxyline')
local gls = gl.section

gl.short_line_list = {
  'LuaTree',
  'vista',
  'dbui',
  'startify',
  'term',
  'plug',
  'nerdtree',
  'fugitive',
  'fugitiveblame',
  'SpaceVimPlugManager',
}

local colors = {
  bg       = '#3c3836',
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

local buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

gls.left[1] = {
  FirstElement = {
    provider = function()
      return '▊ '
    end,
    highlight = {colors.blue, colors.line_bg},
  },
}

gls.left[2] = {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local alias = {
				n = 'NORMAL',
				i = 'INSERT',
				c = 'COMMAND',
				v = 'VISUAL', 
				V = 'VISUAL', 
			}
      local mode_color = {
        n = colors.magenta,
        i = colors.green,
        c = colors.red,
        v = colors.blue,
        V = colors.blue,
      }
      local mode = vim.fn.mode()
      vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[mode])
      return alias[mode] .. '   '
    end,
    highlight = {colors.red, colors.line_bg, 'bold'},
  },
}

gls.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color, colors.line_bg},
  },
}

gls.left[4] = {
  FileName = {
    provider = function()
      local filename = require('galaxyline.provider_fileinfo').get_current_file_name()  
      local filepath = vim.fn.expand('%:p')
      local size = vim.fn.getfsize(filepath)
      if size <= 0 then
        size = ''
      else
        if size < 1024 then
          size = size .. 'B '
        elseif size < 1024 * 1024 then
          size = string.format('%.1f',size/1024) .. 'K '
        elseif size < 1024 * 1024 * 1024 then
          size = string.format('%.1f',size/1024/1024) .. 'M '
        else
          size = string.format('%.1f',size/1024/1024/1024) .. 'G '
        end
      end
      return filename .. size
    end,
    condition = buffer_not_empty,
    highlight = {colors.fg, colors.line_bg, 'bold'},
  },
}

gls.left[5] = {
  GitIcon = {
    provider = function()
      return '\u{f1d2} '
    end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.orange, colors.line_bg},
  },
}

gls.left[6] = {
  GitBranch = {
    provider = function() 
      if vim.g['coc_git_status'] ~= nil then
        return vim.g['coc_git_status'] .. ' '
      end
      return ' '
    end;
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = {colors.fg, colors.line_bg, 'bold'},
  },
}

local checkwidth = function()
  return (vim.fn.winwidth(0) / 2) > 40
end

gls.left[7] = {
  DiffAdd = {
    provider = function()
      local result = ''
      local status = vim.b['coc_git_status']   
      if status ~= nil then
        local diffs = vim.fn.split(status, ' ')  
        for _, diff in ipairs(diffs) do
          local prefix = string.sub(diff, 1, 1)
          local number = string.sub(diff, 2)
          if prefix == '+' then
            result = result .. '  ' .. number
          elseif prefix == '~' then
            result = result .. '  ' .. number
          elseif prefix == '-' then
            result = result .. '  ' .. number
          end
        end
        return result .. ' '
      end
    end,
    condition = checkwidth,
    highlight = {colors.green, colors.line_bg},
  },
}

gls.left[8] = {
  LeftEnd = {
    provider = function()
      return '\u{e0b0}'
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
  FileFormat = {
    provider = function()
      if vim.bo.fenc ~= '' then 
        return string.format(' %s [%s]', vim.bo.fileformat, vim.bo.fenc)
      else
        return string.format(' %s [%s]', vim.bo.fileformat, vim.o.enc)
      end
    end,
    separator = '\u{e0b2}',
    separator_highlight = {colors.line_bg, colors.bg},
    highlight = {colors.fg, colors.line_bg, 'bold'},
  },
}

gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.blue, colors.line_bg},
    highlight = {colors.fg, colors.line_bg},
  },
}

gls.right[3] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' |',
    separator_highlight = {colors.blue, colors.line_bg},
    highlight = {colors.fg, colors.line_bg, 'bold'},
  },
}

gls.right[4] = {
  ScrollBar = {
    provider = 'ScrollBar', 
    highlight = {colors.blue, colors.line_bg}
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '\u{e0b0}',
    separator_highlight = {colors.line_bg, colors.bg},
    highlight = {colors.fg, colors.line_bg},
  },
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = 'BufferIcon',
    separator = '\u{e0b2}',
    separator_highlight = {colors.line_bg, colors.bg},
    highlight = {colors.fg, colors.line_bg},
  },
}
