--=====================================================================
--
-- vim-matchup.lua -
--
-- Created by liubang on 2022/12/31 01:59
-- Last Modified: 2022/12/31 01:59
--
--=====================================================================

-- % go forwards to next matching word. If at a close word, cycle back to the corresponding open word.
return {
  "andymass/vim-matchup",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.g.matchup_matchparen_offscreen = {}
    vim.g.matchup_matchparen_deferred = 1
  end,
}
