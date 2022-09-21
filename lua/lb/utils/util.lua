--=====================================================================
--
-- util.lua -
--
-- Created by liubang on 2022/09/04 17:33
-- Last Modified: 2022/09/04 17:33
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

return M
