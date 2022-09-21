--=====================================================================
--
-- complete.lua -
--
-- Created by liubang on 2022/09/21 22:14
-- Last Modified: 2022/09/21 22:14
--
--=====================================================================

local M = {}

M.impl_complete = function(arglead, cmdline, cursorpos)
  return table.concat(require('lb.go.impl').complete(arglead, cmdline, cursorpos), '\n')
end

return M
