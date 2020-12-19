--=====================================================================
--
-- init.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
--=====================================================================

local g, fn = vim.g, vim.fn

return function(v)
  g.nvg_version = v
  g.nvg_root = fn.stdpath('config')
  g.cache_path  = g.nvg_root .. '/.cache'
  g.module_path = g.nvg_root .. '/modules'
  g.snip_path   = g.nvg_root .. '/snippets'

  local p = assert(io.popen('find "' .. g.module_path ..'" -name "*.toml"'))
  local modules = {}
  for file in p:lines() do
    table.insert(modules, file)
  end

  -- plugins
  -- require('lb.plugins')
  require('lb.utils.pm').setup(modules)

  require('lb.options')
  require('lb.mappings')
  require('lb.events')
  require('lb.commands')
end
