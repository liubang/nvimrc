-- =====================================================================
--
-- init.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================
local g, fn = vim.g, vim.fn
local app = {}

_G.check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.dump = function(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

app.run = function(v)
  -- LuaFormatter off
  g.nvg_version = v
  g.nvg_root    = fn.stdpath('config')
  g.cache_path  = string.format('%s/.cache', g.nvg_root)
  g.module_path = string.format('%s/modules', g.nvg_root)
  g.snip_path   = string.format('%s/snippets', g.nvg_root)

  -- plugins
  -- require('lb.plugins')
  require('lb.utils.pm').setup(
    require('lb.utils.fs').list_files(g.module_path, '*.toml')
  )
  -- LuaFormatter on
  require('lb.options')
  require('lb.mappings')
  require('lb.events')
  require('lb.commands')
end

return app
