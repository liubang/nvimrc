--=====================================================================
--
-- crates.lua -
--
-- Created by liubang on 2022/12/30 22:03
-- Last Modified: 2022/12/30 22:03
--
--=====================================================================
return {
  "saecki/crates.nvim",
  event = { "BufReadPre Cargo.toml" },
  config = function()
    require("crates").setup {
      popup = {
        autofocus = true,
      },
    }
  end,
}

-- vim: fdm=marker fdl=0
