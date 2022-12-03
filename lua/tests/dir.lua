--=====================================================================
--
-- dir.lua -
--
-- Created by liubang on 2022/12/04 03:54
-- Last Modified: 2022/12/04 03:54
--
--=====================================================================

local util = require 'lb.utils.util'
local root = util.root_pattern('.git', 'init.lua', 'task.ini')(vim.fn.expand '%:p')
vim.pretty_print(vim.fn.expand '%')
vim.pretty_print(root)
