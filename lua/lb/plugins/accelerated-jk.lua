--=====================================================================
--
-- accelerated-jk.lua -
--
-- Created by liubang on 2022/12/30 22:12
-- Last Modified: 2022/12/30 22:12
--
--=====================================================================
return {
  "rainbowhxch/accelerated-jk.nvim",
  lazy = false,
  config = function()
    require("accelerated-jk").setup {
      mode = "time_driven",
      enable_deceleration = false,
      acceleration_motions = {},
      acceleration_limit = 150,
      acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
      deceleration_table = { { 150, 9999 } },
    }
  end,
}

-- vim: fdm=marker fdl=0
