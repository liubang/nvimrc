--=====================================================================
--
-- autopairs.lua -
--
-- Created by liubang on 2022/09/03 17:42
-- Last Modified: 2022/09/03 17:42
--
--=====================================================================
-- autopairs

local autopairs = require 'nvim-autopairs'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
local cmp = require 'cmp'

autopairs.setup {
  check_ts = true,
  ignored_next_char = '[%w%.]',
  ts_config = {
    lua = { 'string' },
  },
  disable_filetype = { 'TelescopePrompt', 'vim' },
}
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
