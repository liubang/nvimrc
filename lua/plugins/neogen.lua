--=====================================================================
--
-- neogen.lua -
--
-- Created by liubang on 2023/01/16 14:12
-- Last Modified: 2023/01/16 14:12
--
--=====================================================================
return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    snippet_engine = "luasnip",
  },
  cmd = { "Neogen" },
  keys = {
    { "<Leader>nf", "<CMD>Neogen<CR>", mode = { "n" } },
  },
}

-- vim: fdm=marker fdl=0
