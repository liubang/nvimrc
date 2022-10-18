--=====================================================================
--
-- nvim-notify.lua -
--
-- Created by liubang on 2022/09/03 17:01
-- Last Modified: 2022/10/18 23:28
--
--=====================================================================

local notify = require 'notify'
notify.setup {
  timeout = 3000,
}
vim.notify = notify
