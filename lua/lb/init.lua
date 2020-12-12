--=====================================================================
--
-- init.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
--=====================================================================

local g = vim.g

local modules_dir = g.nvg_root .. '/modules'
local p = assert(io.popen('find "' .. modules_dir ..'" -name "*.toml"'))
local modules = {}
for file in p:lines() do
  table.insert(modules, file)
end

-- plugins
require('lb.utils.pm').setup(modules)

require('lb.options')
require('lb.mappings')
require('lb.events')
require('lb.commands')
