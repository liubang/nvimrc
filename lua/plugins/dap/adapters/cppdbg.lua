--=====================================================================
--
-- cppdbg.lua -
--
-- Created by liubang on 2023/02/18 21:37
-- Last Modified: 2023/02/18 21:37
--
--=====================================================================
local dap = require 'dap'

dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = 'OpenDebugAD7',
}
