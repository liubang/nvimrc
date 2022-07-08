--=====================================================================
--
-- string.lua -
--
-- Created by liubang on 2021/01/15 14:59
-- Last Modified: 2021/01/15 14:59
--
--=====================================================================

local M = {}

M.rtrim = function(s)
  local n = #s
  while n > 0 and s:find('^%s', n) do
    n = n - 1
  end
  return s:sub(1, n)
end

return M
