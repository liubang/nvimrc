--=====================================================================
--
-- hop.lua -
--
-- Created by liubang on 2022/12/30 22:18
-- Last Modified: 2022/12/30 22:18
--
--=====================================================================
return {
  "phaazon/hop.nvim",
  branch = "v2",
  event = { "BufReadPost" },
  config = function()
    require("hop").setup {}
  end,
}

-- vim: fdm=marker fdl=0
