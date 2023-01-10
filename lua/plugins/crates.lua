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
  opts = {
    popup = {
      autofocus = true,
    },
  },
}

-- vim: fdm=marker fdl=0
