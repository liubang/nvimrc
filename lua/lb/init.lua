-- =====================================================================
--
-- init.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================
local g, o, fn = vim.g, vim.o, vim.fn

-- global functions 
_G.P = function(v)
  print(vim.inspect(v))
  return v
end
_G.folds_render = require('lb.utils.folds').render
_G.is_special_buffer = require('lb.utils.buffer').is_special_buffer
_G.check_back_space = require('lb.utils.buffer').check_back_space

local app = {}
function app:new(v)
  local instance = {nvg_version = v}
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function app:run()
  -- LuaFormatter off
  g.nvg_version  = self.nvg_version
  g.nvg_root     = fn.stdpath('config')
  g.cache_path   = string.format('%s/.cache', g.nvg_root)
  g.module_path  = string.format('%s/modules', g.nvg_root)
  g.snip_path    = string.format('%s/snippets', g.nvg_root)
  g.scripts_path = string.format('%s/scripts', g.nvg_root)
  -- LuaFormatter on

  require('lb.globals')
  require('lb.options')
  require('lb.plugins')
  require('lb.mappings')
  require('lb.events')
  require('lb.commands')
end

return app
