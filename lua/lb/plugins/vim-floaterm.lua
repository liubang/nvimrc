--=====================================================================
--
-- vim-floaterm.lua -
--
-- Created by liubang on 2022/12/30 22:18
-- Last Modified: 2022/12/30 22:18
--
--=====================================================================
return {
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_wintype = "float"
    vim.g.floaterm_position = "bottom"
    vim.g.floaterm_autoinsert = true
    vim.g.floaterm_width = 0.999
    vim.g.floaterm_height = 0.7
    vim.g.floaterm_title = "─────  Floaterm [$1|$2] "
  end,
  cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
}

-- vim: fdm=marker fdl=0
