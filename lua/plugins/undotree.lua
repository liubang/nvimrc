--=====================================================================
--
-- undotree.lua -
--
-- Created by liubang on 2022/12/30 22:28
-- Last Modified: 2022/12/30 22:28
--
--=====================================================================
return {
  "mbbill/undotree",
  branch = "search",
  cmd = { "UndotreeShow", "UndotreeToggle" },
  config = function()
    vim.g.undotree_CustomUndotreeCmd = "vertical 40 new"
    vim.g.undotree_CustomDiffpanelCmd = "botright 15 new"
  end,
  keys = {
    { "<Leader>u", "<CMD>UndotreeToggle<CR>", mode = { "n" }, desc = "Toggle undotree" },
  },
}

-- vim: fdm=marker fdl=0
