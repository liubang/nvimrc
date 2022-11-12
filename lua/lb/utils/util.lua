--=====================================================================
--
-- util.lua -
--
-- Created by liubang on 2022/09/04 17:33
-- Last Modified: 2022/11/13 02:05
--
--=====================================================================

local M = {}

local os_name = vim.loop.os_uname().sysname
local is_windows = os_name == 'Windows' or os_name == 'Windows_NT'

math.randomseed(os.time())

M.uuid = function() --{{{
  local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  local out
  local function subs(c)
    local v = (((c == 'x') and math.random(0, 15)) or math.random(8, 11))
    return string.format('%x', v)
  end
  out = template:gsub('[xy]', subs)
  return out
end --}}}

local charset = {} -- Random String {{{
for i = 48, 57 do
  table.insert(charset, string.char(i))
end
for i = 65, 90 do
  table.insert(charset, string.char(i))
end
for i = 97, 122 do
  table.insert(charset, string.char(i))
end
M.random_string = function(length)
  if length == 0 then
    return ''
  end
  return M.random_string(length - 1) .. charset[math.random(1, #charset)]
end --}}}

---Runs the command in shell.
-- @param command string
-- @return table
M.shell = function(command) --{{{
  local file = io.popen(command, 'r')
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end --}}}

M.chdir = function(dir)
  if vim.fn.exists '*chdir' then
    return vim.fn.chdir(dir)
  end

  local oldir = vim.fn.getcwd()
  local cd = 'cd'
  if vim.fn.exists '*haslocaldir' and vim.fn.haslocaldir() then
    cd = 'lcd'
    vim.cmd(cd .. ' ' .. vim.fn.fnameescape(dir))
    return oldir
  end
end

M.exec_in_path = function(cmd, bufnr, ...)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local path = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':p:h')
  local dir = M.chdir(path)
  local result
  if type(cmd) == 'function' then
    result = cmd(bufnr, ...)
  else
    result = vim.fn.systemlist(cmd, ...)
  end
  M.chdir(dir)
  return result
end

M.sep = function()
  if is_windows then
    return '\\'
  end
  return '/'
end

M.rel_path = function(folder)
  local mod = '%:p'
  if folder then
    mod = '%:p:h'
  end
  local fpath = vim.fn.expand(mod)
  local workfolders = vim.lsp.buf.list_workspace_folders()
  if vim.fn.empty(workfolders) == 0 then
    fpath = '.' .. fpath:sub(#workfolders[1] + 1)
  else
    fpath = vim.fn.fnamemodify(vim.fn.expand(mod), ':p:.')
  end
  if fpath:sub(#fpath) == M.sep() then
    fpath = fpath:sub(1, #fpath - 1)
  end
  return fpath
end

M.trim_whitespace = function()
  if not vim.bo.modifiable or vim.bo.binary or vim.bo.filetype == 'diff' then
    return
  end
  local ok, val = pcall(vim.api.nvim_buf_get_var, 0, 'DISABLE_TRIM_WHITESPACES')
  if ok and val then
    return
  end
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command [[keeppatterns %s/\s\+$//e]]
  vim.api.nvim_command [[silent! %s#\($\n\s*\)\+\%$##]]
  vim.api.nvim_win_set_cursor(0, cursor)
end

M.rtrim = function(s)
  local n = #s
  while n > 0 and s:find('^%s', n) do
    n = n - 1
  end
  return s:sub(1, n)
end

M.ltrim = function(s)
  return (s:gsub('^%s*', ''))
end

M.trim = function(s)
  if s then
    s = M.ltrim(s)
    return M.rtrim(s)
  end
end

return M
