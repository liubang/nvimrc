--=====================================================================
--
-- package.lua -
--
-- Created by liubang on 2022/09/21 21:45
-- Last Modified: 2022/09/21 21:45
--
--=====================================================================

local M = {}
local util = require 'lb.utils.util'

M.pkg_from_path = function(pkg, bufnr)
  local cmd = { 'go', 'list' }
  if pkg ~= nil then
    table.insert(cmd, pkg)
  end
  return util.exec_in_path(cmd, bufnr)
end

return M
