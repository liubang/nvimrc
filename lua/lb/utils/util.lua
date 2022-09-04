--=====================================================================
--
-- util.lua -
--
-- Created by liubang on 2022/09/04 17:33
-- Last Modified: 2022/09/04 17:33
--
--=====================================================================

local M = {}

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

return M
