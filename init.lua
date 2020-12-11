--=====================================================================
--
-- init.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:22
--
--=====================================================================

local script_path = string.gsub(debug.getinfo(1).source, "^@(.+/)[^/]+$", "%1")
require('lb').run(script_path)
