--=====================================================================
--
-- objects.lua -
--
-- Created by liubang on 2022/07/09 02:24
-- Last Modified: 2022/07/09 02:24
--
--=====================================================================
local M = {}

M.empty = function(t)
  if t == nil then
    return true
  end
  if type(t) ~= 'table' then
    return false
  end
  return next(t) == nil
end

return M
