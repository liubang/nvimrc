--=====================================================================
--
-- undotree.lua -
--
-- Created by liubang on 2023/11/26 16:05
-- Last Modified: 2023/11/26 16:05
--
--=====================================================================

return {
  "mbbill/undotree", -- {{{
  branch = "search",
  cmd = { "UndotreeShow", "UndotreeToggle" },
  config = function()
    vim.g.undotree_CustomUndotreeCmd = "vertical 40 new"
    vim.g.undotree_CustomDiffpanelCmd = "botright 15 new"
  end,
  keys = {
    { "<Leader>u", "<CMD>UndotreeToggle<CR>", mode = { "n" }, desc = "Toggle undotree" },
  },
  -- }}}
}
