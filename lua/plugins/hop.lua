--=====================================================================
--
-- hop.lua -
--
-- Created by liubang on 2022/12/30 22:18
-- Last Modified: 2022/12/30 22:18
--
--=====================================================================

-- stylua: ignore start

return {
  "phaazon/hop.nvim",
  branch = "v2",
  config = true,
  keys = {
    { "<Leader>kk", function() require("hop").hint_lines() end, mode = { "n" } },
    { "<Leader>jj", function() require("hop").hint_lines() end, mode = { "n" } },
    { "<Leader>ss", function() require("hop").hint_patterns() end, mode = { "n" } },
    {
      "<Leader>ll",
      function()
        require("hop").hint_words {
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true,
        }
      end,
      mode = { "n" }
    },
    {
      "<Leader>hh",
      function()
        require("hop").hint_words {
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        }
      end,
      mode = { "n" }
    },
  },
}

-- stylua: ignore end

-- vim: fdm=marker fdl=0
