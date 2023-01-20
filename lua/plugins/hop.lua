--=====================================================================
--
-- hop.lua -
--
-- Created by liubang on 2022/12/30 22:18
-- Last Modified: 2023/01/20 19:53
--
--=====================================================================

return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = true,
  keys = {
    {
      "<Leader>kk",
      function()
        require("hop").hint_lines()
      end,
      mode = { "n" },
      desc = "Hint the beginning of each lines currently visible in the buffer view and allow to jump to them",
    },
    {
      "<Leader>jj",
      function()
        require("hop").hint_lines()
      end,
      mode = { "n" },
      desc = "Hint the beginning of each lines currently visible in the buffer view and allow to jump to them",
    },
    {
      "<Leader>ss",
      function()
        require("hop").hint_patterns()
      end,
      mode = { "n" },
      desc = "Annotate all matched patterns in the current window with key sequences",
    },
    {
      "<Leader>ll",
      function()
        require("hop").hint_words {
          direction = require("hop.hint").HintDirection.AFTER_CURSOR,
          -- current_line_only = true,
        }
      end,
      mode = { "n" },
      desc = "Annotate all words in the current line with key sequences",
    },
    {
      "<Leader>hh",
      function()
        require("hop").hint_words {
          direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
          -- current_line_only = true,
        }
      end,
      mode = { "n" },
      desc = "Annotate all words in the current line with key sequences",
    },
  },
}

-- vim: fdm=marker fdl=0
