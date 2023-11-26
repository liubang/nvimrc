--=====================================================================
--
-- acceleratedjk-nvim.lua -
--
-- Created by liubang on 2023/11/26 15:41
-- Last Modified: 2023/11/26 15:41
--
--=====================================================================

return {
  "rainbowhxch/accelerated-jk.nvim", -- {{{
  keys = {
    { "j", "<Plug>(accelerated_jk_gj)", mode = { "n" }, desc = "Accelerated gj movement" },
    { "k", "<Plug>(accelerated_jk_gk)", mode = { "n" }, desc = "Accelerated gk movement" },
  },
  opts = {
    mode = "time_driven",
    enable_deceleration = false,
    acceleration_motions = {},
    acceleration_limit = 150,
    acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
    deceleration_table = { { 150, 9999 } },
  },
  -- }}}
}
-- vim: fdm=marker fdl=0
