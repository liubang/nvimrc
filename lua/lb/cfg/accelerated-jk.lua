--=====================================================================
--
-- accelerated-jk.lua -
--
-- Created by liubang on 2022/12/05 00:53
-- Last Modified: 2022/12/07 23:39
--
--=====================================================================

require("accelerated-jk").setup {
  mode = "time_driven",
  enable_deceleration = false,
  acceleration_motions = {},
  acceleration_limit = 150,
  acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
  deceleration_table = { { 150, 9999 } },
}
