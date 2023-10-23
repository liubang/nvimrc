--=====================================================================
--
-- go.lua -
--
-- Created by liubang on 2023/02/18 21:27
-- Last Modified: 2023/02/18 21:27
--
--=====================================================================
local dap = require 'dap'

dap.adapters.go = {
    type = 'server',
    port = '${port}',
    executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
    },
}
