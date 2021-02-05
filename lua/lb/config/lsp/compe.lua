-- =====================================================================
--
-- nvim_compe.lua - 
--
-- Created by liubang on 2021/02/06 00:11
-- Last Modified: 2021/02/06 00:11
--
-- =====================================================================
local nvim_compe = require('compe')

-- nvim-compe
nvim_compe.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'always',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  allow_prefix_unmatch = false,
  source = {
    path = true,
    calc = true,
    buffer = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    snippets_nvim = true,
  },
}

