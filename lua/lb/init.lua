--=====================================================================
--
-- init.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
--=====================================================================

vim.fn['pm#_start']()

require('lb.options')
require('lb.mappings')
require('lb.events')

vim.schedule(function() 
  require('lb.utils.comment').setup() 
end)
