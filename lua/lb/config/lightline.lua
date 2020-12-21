-- =====================================================================
--
-- lightline.lua - 
--
-- Created by liubang on 2020/12/12 22:10
-- Last Modified: 2020/12/12 22:10
--
-- =====================================================================
local g = vim.g
local M = {}
local devicons = require('nvim-web-devicons')

local function get_buffer_number()
  local i = 0
  local buffers = vim.fn.filter(
    vim.fn.range(1, vim.fn.bufnr('$')), 'bufexists(v:val) && buflisted(v:val)'
  )
  for _, nr in pairs(buffers) do
    i = i + 1
    if nr == vim.fn.bufnr('') then
      return i
    end
  end
  return 0
end

M.set_options = function()
  g['lightline'] = {
    colorscheme = 'gruvbox_material',
    active = {
      left = {{'homemode'}, {'gitbranch', 'filename', 'filesize'}, {'cocerror'}, {'cocwarn'}},
      right = {{'linenumber'}, {'fileformat'}},
    },
    inactive = {left = {{'homemode'}, {'gitbranch', 'filename', 'filesize'}}, right = {{'linenumber'}, {'fileformat'}}},
    tabline = {left = {{'buffers'}}, right = {{'sign'}}},
    component = {sign = '\u{f18a}'},
    component_expand = {buffers = 'lightline#bufferline#buffers'},
    component_function = {
      linenumber = 'LightlineLineinfo',
      homemode = 'LightlineHomemode',
      cocerror = 'LightlineCocError',
      cocwarn = 'LightlineCocWarn',
      gitbranch = 'LightlineGitBranch',
      gitstatus = 'LightlineGitStatus',
      filename = 'LightlineFname',
      filesize = 'LightlineFsize',
      fileformat = 'LightlineFileformat',
    },
    component_type = {buffers = 'tabsel'},
    separator = {left = '\u{e0b0}', right = '\u{e0b2}'},
    subseparator = {left = '\u{e0b1}', right = '\u{e0b3}'},
  }

  g['lightline#bufferline#show_number'] = 2
  g['lightline#bufferline#shorten_path'] = 1
  g['lightline#bufferline#enable_devicons'] = 1
  g['lightline#bufferline#filename_modifier'] = ':t'
  g['lightline#bufferline#unnamed'] = '[No Name]'
  -- g['lightline#bufferline#composed_number_map'] = nmap
  vim.cmd [[autocmd User CocDiagnosticChange call lightline#update()]]
end

M.LightlineLineinfo = function()
  if vim.fn['utils#is_special_buffer']() == 1 then
    return ''
  end
  local c = vim.fn.line('.')
  local e = vim.fn.line('$')
  local o = vim.fn.col('.')
  return math.floor(c * 100 / e) .. '%' .. '  ' .. c .. ':' .. o
end

M.LightlineFileformat = function()
  if vim.fn['utils#is_special_buffer']() == 1 or vim.fn.winwidth(0) <= 70 then
    return ''
  end
  local fenc = vim.api.nvim_get_option('fenc')
  local icon = vim.fn['WebDevIconsGetFileFormatSymbol']()
  if fenc ~= '' then
    return icon .. ' ' .. fenc .. ' | ' .. vim.o.fileformat
  else
    return icon .. ' ' .. vim.o.enc .. ' | ' .. vim.o.fileformat
  end
end

M.LightlineHomemode = function()
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
  if buftype == 'terminal' or buftype == 'quickfix' or vim.fn['utils#is_special_buffer']() == 1 then
    return string.upper(buftype)
  end
  local nr = get_buffer_number()
  if nr == 0 then
    return ''
  end
  -- local number = nr
  -- local result = nr
  -- for _ = 1, string.len(tostring(number)), 1 do
  --   result = nmap[tostring(number % 10)] .. result
  --   number = math.floor(number / 10)
  -- end
  return '🌈 ' .. nr
end

M.LightlineModified = function()
  if vim.o.modified then
    return '+'
  else
    return ''
  end
end

M.LightlineReadonly = function()
  if vim.o.readonly then
    return '\u{f023}'
  else
    return ''
  end
end

M.LightlineGitBranch = function()
  if vim.fn['utils#is_special_buffer']() == 1 then
    return ''
  end
  return g['coc_git_status'] or ''
end

M.LightlineGitStatus = function()
  if vim.fn['utils#is_special_buffer']() == 1 or vim.b['coc_git_status'] == nil then
    return ''
  end
  return vim.b['coc_git_status'] or ''
end

M.LightlineCocError = function()
  local error_sign = g['coc_status_error_sign'] or '\u{f00d}'
  local info = vim.b['coc_diagnostic_info']
  if info ~= nil and info['error'] ~= nil and info['error'] > 0 then
    return error_sign .. ' ' .. info['error']
  end
  return ''
end

M.LightlineCocWarn = function()
  local warning_sign = g['coc_status_warning_sign'] or '\u{f12a}'
  local info = vim.b['coc_diagnostic_info']
  if info ~= nil and info['warning'] ~= nil and info['warning'] > 0 then
    return warning_sign .. ' ' .. info['warning']
  end
  return ''
end

M.LightlineFsize = function()
  if vim.fn['utils#is_special_buffer']() == 1 then
    return ''
  end
  return '  ' .. require('lb.utils.fs').file_size(vim.fn.expand('%:p'))
end

M.LightlineFname = function()
  if vim.fn['utils#is_special_buffer']() == 1 then
    return ''
  end
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  local filename = vim.fn.expand('%:t')
  local ext = vim.fn.expand('%:e')
  local icon = ''
  if filetype ~= '' then
    icon = devicons.get_icon(filename, ext, {default = true})
  end
  if M.LightlineReadonly() ~= '' then
    filename = M.LightlineReadonly() .. ' ' .. filename
  end
  if M.LightlineModified() ~= '' then
    filename = filename .. ' '
    M.LightlineModified()
  end
  return icon .. ' ' .. filename
end

M.set_functions = function()
  vim.api.nvim_exec([[
    function! LightlineLineinfo() 
      return luaeval("require('lb.config.lightline').LightlineLineinfo()")
    endfunc

    function! LightlineHomemode() 
      return luaeval("require('lb.config.lightline').LightlineHomemode()")
    endfunc

    function! LightlineCocError() 
      return luaeval("require('lb.config.lightline').LightlineCocError()")
    endfunc

    function! LightlineCocWarn() 
      return luaeval("require('lb.config.lightline').LightlineCocWarn()")
    endfunc

    function! LightlineGitBranch() 
      return luaeval("require('lb.config.lightline').LightlineGitBranch()")
    endfunc

    function! LightlineGitStatus() 
      return luaeval("require('lb.config.lightline').LightlineGitStatus()")
    endfunc

    function! LightlineFname() 
      return luaeval("require('lb.config.lightline').LightlineFname()")
    endfunc

    function! LightlineFsize()
      return luaeval("require('lb.config.lightline').LightlineFsize()")
    endfunc
    
    function! LightlineFileformat() 
      return luaeval("require('lb.config.lightline').LightlineFileformat()")
    endfunc
  ]], false)
end

M.on_attach = function()
  M.set_functions()
  M.set_options()
end

return M
