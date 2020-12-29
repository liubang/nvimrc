-- =====================================================================
--
-- version.lua - 
--
-- Created by liubang on 2020/12/29 15:55
-- Last Modified: 2020/12/29 15:55
--
-- =====================================================================
local fn = vim.fn

local nvim_version = function()
  return fn.matchstr(fn.execute('version'), 'NVIM v\\zs[^\\n]*')
end

return {nvim_version = nvim_version}
