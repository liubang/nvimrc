--=====================================================================
--
-- nvim-surround.lua -
--
-- Created by liubang on 2022/07/13 22:33
-- Last Modified: 2022/07/13 22:33
--
--=====================================================================

require('nvim-surround').setup {
  keymaps = { -- vim-surround style keymaps
    insert = nil,
    insert_line = nil,
    visual = 'S',
    delete = 'ds',
    change = 'cs',
  },
  delimiters = {
    pairs = {
      ['('] = { '( ', ' )' },
      [')'] = { '(', ')' },
      ['{'] = { '{ ', ' }' },
      ['}'] = { '{', '}' },
      ['<'] = { '< ', ' >' },
      ['>'] = { '<', '>' },
      ['['] = { '[ ', ' ]' },
      [']'] = { '[', ']' },
      -- Define pairs based on function evaluations!
      ['i'] = function()
        return {
          require('nvim-surround.utils').get_input 'Enter the left delimiter: ',
          require('nvim-surround.utils').get_input 'Enter the right delimiter: ',
        }
      end,
      ['f'] = function()
        return {
          require('nvim-surround.utils').get_input 'Enter the function name: ' .. '(',
          ')',
        }
      end,
    },
    separators = {
      ['\''] = { '\'', '\'' },
      ['"'] = { '"', '"' },
      ['`'] = { '`', '`' },
    },
    HTML = {
      ['t'] = 'type', -- Change just the tag type
      ['T'] = 'whole', -- Change the whole tag contents
    },
    aliases = {
      ['a'] = '>', -- Single character aliases apply everywhere
      ['b'] = ')',
      ['B'] = '}',
      ['r'] = ']',
      -- Table aliases only apply for changes/deletions
      ['q'] = { '"', '\'', '`' }, -- Any quote character
      ['s'] = { ')', ']', '}', '>', '\'', '"', '`' }, -- Any surrounding delimiter
    },
  },
  highlight_motion = { -- Highlight before inserting/changing surrounds
    duration = 0,
  },
}
