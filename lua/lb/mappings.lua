-- =====================================================================
--
-- mappings.lua -
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
-- =====================================================================

local keymap = vim.keymap

local mappings = {}

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- clear default
keymap.set('n', ',', '', { silent = true })
keymap.set('n', 'm', '', { silent = true })
keymap.set('x', ',', '', { silent = true })
keymap.set('x', 'm', '', { silent = true })

mappings.general = {
  v = {
    ['<Tab>'] = { '>gv|', '-> move right' },
    ['<S-Tab>'] = { '<gv', '<- move left' },
  },
  n = {
    ['<Tab>'] = { '>>_', '-> move right' },
    ['<S-Tab>'] = { '<<_', '<- move left' },
  },
  x = {
    ['<'] = { '<gv' },
    ['>'] = { '>gv' },
  },
  -- bash like
  i = {
    ['<C-a>'] = { '<Home>', 'beginning of line' },
    ['<C-e>'] = { '<End>', 'end of line' },
  },
}

mappings.buffer = {
  n = {
    ['<Leader>bp'] = { '<cmd>bprevious<CR>', 'goto previous buffer' },
    ['<Leader>bn'] = { '<cmd>bnext<CR>', 'goto next buffer' },
    ['<Leader>bf'] = { '<cmd>bfirst<CR>', 'goto first buffer' },
    ['<Leader>bl'] = { '<cmd>blast<CR>', 'goto last buffer' },
  },
}

mappings.window = {
  n = {
    ['<Leader>ww'] = { '<C-W>w', 'move cursor to window below/right' },
    ['<Leader>wr'] = { '<C-W>r', 'rotate windows downwards/rightwards' },
    ['<Leader>wq'] = { '<C-W>q', 'quit current window' },
    ['<Leader>wh'] = { '<C-W>h', ' window left' },
    ['<Leader>wl'] = { '<C-W>l', ' window right' },
    ['<Leader>wj'] = { '<C-W>j', ' window down' },
    ['<Leader>wk'] = { '<C-W>k', ' window up' },
    ['<Leader>w='] = { '<C-W>=', 'make all windows size equally' },
    ['<Leader>ws'] = { '<C-W>s', 'split current window in two' },
    ['<Leader>wv'] = { '<C-W>v', 'split vertically current window' },
    ['<C-S-Up>'] = {
      function()
        require('smart-splits').resize_up()
      end,
      'Resize split up',
    },
    ['<C-S-Down>'] = {
      function()
        require('smart-splits').resize_down()
      end,
      'Resize split down',
    },
    ['<C-S-Left>'] = {
      function()
        require('smart-splits').resize_left()
      end,
      'Resize split left',
    },
    ['<C-S-Right>'] = {
      function()
        require('smart-splits').resize_right()
      end,
      'Resize split right',
    },
    -- ['<Leader>w+'] = { '<C-W>5+', 'increase window height' },
    -- ['<Leader>w-'] = { '<C-W>5-', 'decrease window height' },
    -- ['<Leader>w.'] = { '<C-W>5>', 'increase window width' },
    -- ['<Leader>w,'] = { '<C-W>5<', 'decrease window width' },
  },
}

mappings.command = {
  c = {
    ['<C-a>'] = { '<Home>', '' },
    ['<C-e>'] = { '<End>', '' },
    ['<C-b>'] = { '<S-Left>', '' },
    ['<C-f>'] = { '<S-Right>', '' },
    ['<C-h>'] = { '<Left>', '' },
    ['<C-l>'] = { '<Right>', '' },
  },
}

mappings.terminal = {
  t = {
    ['<Esc>'] = { termcodes '<C-\\><C-N>', '   escape terminal mode' },
  },
}

--------- plugins key mappings

mappings.neotree = {
  n = {
    ['<Leader>ft'] = {
      '<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<CR>',
      '   toggle neotree',
    },
  },
}

mappings.easyalign = {
  n = {
    ['ga'] = { '<Plug>(EasyAlign)', 'start interactive EasyAlign for a motion/text object' },
  },
  x = {
    ['ga'] = { '<Plug>(EasyAlign)', 'start interactive EasyAlign in visual mode' },
  },
}

mappings.floaterm = {
  n = {
    ['<Leader>tw'] = { '<cmd>FloatermNew<CR>', 'create a new terminal window' },
    ['<C-t>'] = { '<cmd>FloatermToggle<CR>', 'toggle terminal' },
  },
  t = {
    ['<C-n>'] = { termcodes '<C-\\><C-N>:FloatermNew<CR>', 'create a new terminal window' },
    ['<C-k>'] = { termcodes '<C-\\><C-N>:FloatermPrev<CR>', 'goto previous terminal window' },
    ['<C-j>'] = { termcodes '<C-\\><C-N>:FloatermNext<CR>', 'goto next terminal window' },
    ['<C-t>'] = { termcodes '<C-\\><C-N>:FloatermToggle<CR>', 'toggle terminal' },
    ['<C-d>'] = { termcodes '<C-\\><C-N>:FloatermKill<CR>', 'close current terminal window' },
  },
}

mappings.asynctask = {
  n = {
    ['<C-x>'] = { '<cmd>AsyncTask build-and-run<CR>', 'build and execute current file' },
    ['<C-b>'] = { '<cmd>AsyncTask build<CR>', 'build current file' },
    ['<C-r>'] = { '<cmd>AsyncTask run<CR>', 'execute current file' },
  },
}

mappings.outline = {
  n = {
    ['<Leader>tl'] = { '<cmd>SymbolsOutline<CR>', 'toggle symbols outline window' },
  },
}

mappings.hop = {
  n = {
    ['<leader>kk'] = {
      function()
        require('hop').hint_lines()
      end,
      'hint the beginning of each lines',
    },
    ['<leader>jj'] = {
      function()
        require('hop').hint_lines()
      end,
      'hint the beginning of each lines',
    },
    ['<Leader>ss'] = {
      function()
        require('hop').hint_patterns()
      end,
      'annotate all matched patterns in current window',
    },
    ['<leader>ll'] = {
      function()
        require('hop').hint_words {
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true,
        }
      end,
      'annotate all words in the current window with key sequences',
    },
    ['<leader>hh'] = {
      function()
        require('hop').hint_words {
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        }
      end,
      'annotate all words in the current window with key sequences',
    },
  },
}

mappings.accelerate = {
  n = {
    ['j'] = { '<Plug>(accelerated_jk_gj)', '' },
    ['k'] = { '<Plug>(accelerated_jk_gk)', '' },
  },
}

mappings.git = {
  n = {
    ['<Leader>hb'] = {
      function()
        require('gitsigns').blame_line { full = true }
      end,
      'git blame on current line',
    },
    ['<Leader>hd'] = {
      function()
        require('gitsigns').diffthis()
      end,
      'perform a vimdiff on the given file',
    },
  },
}

mappings.markdown = {
  n = {
    ['<Leader>mp'] = { '<cmd>MarkdownPreview<CR>', 'show markdown preview' },
  },
}

mappings.bufferline = {
  n = {
    ['<Leader>bd'] = { '<cmd>Bdelete<CR>', 'delete current buffer' },
    ['<Leader>1'] = {
      '<cmd>BufferLineGoToBuffer 1<CR>',
      'jump to the visible position 1 of the buffer',
    },
    ['<Leader>2'] = {
      '<cmd>BufferLineGoToBuffer 2<CR>',
      'jump to the visible position 2 of the buffer',
    },
    ['<Leader>3'] = {
      '<cmd>BufferLineGoToBuffer 3<CR>',
      'jump to the visible position 3 of the buffer',
    },
    ['<Leader>4'] = {
      '<cmd>BufferLineGoToBuffer 4<CR>',
      'jump to the visible position 4 of the buffer',
    },
    ['<Leader>5'] = {
      '<cmd>BufferLineGoToBuffer 5<CR>',
      'jump to the visible position 5 of the buffer',
    },
    ['<Leader>6'] = {
      '<cmd>BufferLineGoToBuffer 6<CR>',
      'jump to the visible position 6 of the buffer',
    },
    ['<Leader>7'] = {
      '<cmd>BufferLineGoToBuffer 7<CR>',
      'jump to the visible position 7 of the buffer',
    },
    ['<Leader>8'] = {
      '<cmd>BufferLineGoToBuffer 8<CR>',
      'jump to the visible position 8 of the buffer',
    },
    ['<Leader>9'] = {
      '<cmd>BufferLineGoToBuffer 9<CR>',
      'jump to the visible position 9 of the buffer',
    },
  },
}

mappings.telescope = {
  n = {
    ['<Leader>ff'] = {
      function()
        require('telescope.builtin').find_files { previewers = false }
      end,
      'find files',
    },
    ['<Leader>ag'] = {
      function()
        require('telescope.builtin').live_grep()
      end,
      'live grep',
    },
    ['<Leader>Ag'] = {
      function()
        require('telescope.builtin').grep_string()
      end,
      'grep string',
    },
    ['<Leader>bb'] = {
      function()
        require('telescope.builtin').buffers { previewers = false }
      end,
      'find buffers',
    },
    ['<Leader>fc'] = {
      function()
        require('telescope.builtin').commands { previewers = false }
      end,
      'find commands',
    },
    ['<Leader>ts'] = {
      function()
        require('telescope').extensions.tasks.tasks()
      end,
      'show task lists',
    },
  },
}

return mappings
