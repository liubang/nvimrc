--=====================================================================
--
-- vim-matchup.lua -
--
-- Created by liubang on 2023/11/26 15:35
-- Last Modified: 2023/11/26 15:35
--
--=====================================================================
return {
  "andymass/vim-matchup", -- {{{
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.g.matchup_matchparen_offscreen = {}
    vim.g.matchup_matchparen_deferred = 1
  end,
  -- }}}
}
