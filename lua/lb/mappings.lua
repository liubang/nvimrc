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

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- stylua: ignore start
-- clear default
keymap.set('n', ',', '', { silent = true })
keymap.set('n', 'm', '', { silent = true })
keymap.set('x', ',', '', { silent = true })
keymap.set('x', 'm', '', { silent = true })

keymap.set('v', '<Tab>', '>gv|')
keymap.set('v', '<S-Tab>', '<gv')
keymap.set('n', '<Tab>', '>>_')
keymap.set('n', '<S-Tab>', '<<_')
keymap.set('x', '<', '<gv')
keymap.set('x', '>', '>gv')

-- bash like
keymap.set('i', '<C-a>', '<Home>')
keymap.set('i', '<C-e>', '<End>')

-- buffer
keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>')
keymap.set('n', '<Leader>bn', '<cmd>bnext<CR>')
keymap.set('n', '<Leader>bf', '<cmd>bfirst<CR>')
keymap.set('n', '<Leader>bl', '<cmd>blast<CR>')

-- window
keymap.set('n', '<Leader>ww', '<C-W>w')
keymap.set('n', '<Leader>wr', '<C-W>r')
keymap.set('n', '<Leader>wq', '<C-W>q')
keymap.set('n', '<Leader>wh', '<C-W>h')
keymap.set('n', '<Leader>wl', '<C-W>l')
keymap.set('n', '<Leader>wj', '<C-W>j')
keymap.set('n', '<Leader>wk', '<C-W>k')
keymap.set('n', '<Leader>w=', '<C-W>=')
keymap.set('n', '<Leader>ws', '<C-W>s')
keymap.set('n', '<Leader>wv', '<C-W>v')
keymap.set('n', '<C-S-Up>', function() require('smart-splits').resize_up() end)
keymap.set('n', '<C-S-Down>', function() require('smart-splits').resize_down() end)
keymap.set('n', '<C-S-Left>', function() require('smart-splits').resize_left() end)
keymap.set('n', '<C-S-Right>', function() require('smart-splits').resize_right() end)

-- command
keymap.set('c', '<C-a>', '<Home>')
keymap.set('c', '<C-e>', '<End>')
keymap.set('c', '<C-b>', '<S-Left>')
keymap.set('c', '<C-f>', '<S-Right>')
keymap.set('c', '<C-h>', '<Left>')
keymap.set('c', '<C-l>', '<Right>')

-- terminal
keymap.set('t', '<Esc>', termcodes '<C-\\><C-N>')

--------- plugins key mappings

--- neotree
keymap.set(
  'n',
  '<Leader>ft',
  '<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<CR>'
)

--- easyalign
keymap.set('n', 'ga', '<Plug>(EasyAlign)')
keymap.set('x', 'ga', '<Plug>(EasyAlign)')

--- floaterm
keymap.set('n', '<Leader>tw', '<cmd>FloatermNew<CR>')
keymap.set('n', '<C-t>', '<cmd>FloatermToggle<CR>')
keymap.set('t', '<C-n>', termcodes '<C-\\><C-N>:FloatermNew<CR>')
keymap.set('t', '<C-k>', termcodes '<C-\\><C-N>:FloatermPrev<CR>')
keymap.set('t', '<C-j>', termcodes '<C-\\><C-N>:FloatermNext<CR>')
keymap.set('t', '<C-t>', termcodes '<C-\\><C-N>:FloatermToggle<CR>')
keymap.set('t', '<C-d>', termcodes '<C-\\><C-N>:FloatermKill<CR>')


--- asynctask
keymap.set('n', '<C-x>', '<cmd>AsyncTask build-and-run<CR>')
keymap.set('n', '<C-b>', '<cmd>AsyncTask build<CR>')
keymap.set('n', '<C-r>', '<cmd>AsyncTask run<CR>')

--- outline
keymap.set('n', '<Leader>tl', '<cmd>SymbolsOutline<CR>')

--- hop
keymap.set('n', '<Leader>kk', function() require('hop').hint_lines() end)
keymap.set('n', '<Leader>jj', function() require('hop').hint_lines() end)
keymap.set('n', '<Leader>ss', function() require('hop').hint_patterns() end)
keymap.set(
  'n',
  '<Leader>ll',
  function()
    require('hop').hint_words {
      direction = require('hop.hint').HintDirection.AFTER_CURSOR,
      current_line_only = true,
    }
  end
)
keymap.set('n', '<Leader>hh',
  function()
    require('hop').hint_words {
      direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
      current_line_only = true,
    }
  end
)

--- accelerate
keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)')
keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)')

--- git
keymap.set('n', '<Leader>bb', function() require('gitsigns').blame_line {full = true} end)
keymap.set('n', '<Leader>bb', function() require('gitsigns').diffthis() end)

--- markdown
keymap.set('n', '<Leader>mp', '<cmd>MarkdownPreview<CR>')

--- bufferline
keymap.set('n', '<Leader>bd', '<cmd>Bdelete<CR>')
keymap.set('n', '<Leader>1', '<cmd>BufferLineGoToBuffer 1<CR>')
keymap.set('n', '<Leader>2', '<cmd>BufferLineGoToBuffer 2<CR>')
keymap.set('n', '<Leader>3', '<cmd>BufferLineGoToBuffer 3<CR>')
keymap.set('n', '<Leader>4', '<cmd>BufferLineGoToBuffer 4<CR>')
keymap.set('n', '<Leader>5', '<cmd>BufferLineGoToBuffer 5<CR>')
keymap.set('n', '<Leader>6', '<cmd>BufferLineGoToBuffer 6<CR>')
keymap.set('n', '<Leader>7', '<cmd>BufferLineGoToBuffer 7<CR>')
keymap.set('n', '<Leader>8', '<cmd>BufferLineGoToBuffer 8<CR>')
keymap.set('n', '<Leader>9', '<cmd>BufferLineGoToBuffer 9<CR>')

--- telescope
keymap.set('n', '<Leader>ff', function() require('telescope.builtin').find_files() end)
keymap.set('n', '<Leader>ag', function() require('telescope.builtin').live_grep() end)
keymap.set('n', '<Leader>Ag', function() require('telescope.builtin').grep_string() end)
keymap.set('n', '<Leader>bb', function() require('telescope.builtin').buffers() end)
keymap.set('n', '<Leader>fc', function() require('telescope.builtin').commands() end)
keymap.set('n', '<Leader>ts', function() require('telescope').extensions.tasks.tasks() end)

-- stylua: ignore end
