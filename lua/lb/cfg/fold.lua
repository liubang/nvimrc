--=====================================================================
--
-- fold.lua -
--
-- Created by liubang on 2022/09/03 21:19
-- Last Modified: 2022/10/18 23:28
--
--=====================================================================

require('pretty-fold').setup {
  fill_char = '-',
  comment_signs = {},
  keep_indentation = false,
  sections = {
    left = {
      ' »» ',
      function()
        return string.rep('-', vim.v.foldlevel)
      end,
      'content',
    },
    right = {
      ' «« ',
      '[ ',
      'number_of_folded_lines',
      ']',
      function(config)
        return config.fill_char:rep(3)
      end,
    },
  },
}
