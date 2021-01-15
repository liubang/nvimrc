--=====================================================================
--
-- string.lua - 
--
-- Created by liubang on 2021/01/15 14:59
-- Last Modified: 2021/01/15 14:59
--
--=====================================================================

function string:split(sep)
  sep = sep or ':'
  local fields = {}
  local pattern = string.format('([^%s]+)', sep)
  self:gsub(pattern, function(c)
    fields[#fields + 1] = c
  end)
  return fields
end
