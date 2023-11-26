--=====================================================================
--
-- crates-nvim.lua -
--
-- Created by liubang on 2023/11/26 15:39
-- Last Modified: 2023/11/26 15:39
--
--=====================================================================

return {
  "saecki/crates.nvim", -- {{{
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  event = { "BufReadPre Cargo.toml" },
  opts = {
    popup = {
      autofocus = true,
    },
  },
}
