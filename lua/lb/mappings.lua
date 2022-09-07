-- =====================================================================
--
-- mappings.lua -
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
-- =====================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = function(m, l, r)
  local opts = { silent = true }
  vim.keymap.set(m, l, r, opts)
end

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- stylua: ignore start
-- clear default
keymap('n', ',', '')
keymap('n', 'm', '')
keymap('x', ',', '')
keymap('x', 'm', '')

keymap('v', '<Tab>', '>gv|')
keymap('v', '<S-Tab>', '<gv')
keymap('n', '<Tab>', '>>_')
keymap('n', '<S-Tab>', '<<_')
keymap('x', '<', '<gv')
keymap('x', '>', '>gv')

-- bash like
keymap('i', '<C-a>', '<Home>')
keymap('i', '<C-e>', '<End>')

-- buffer
keymap('n', '<Leader>bp', '<cmd>bprevious<CR>')
keymap('n', '<Leader>bn', '<cmd>bnext<CR>')
keymap('n', '<Leader>bf', '<cmd>bfirst<CR>')
keymap('n', '<Leader>bl', '<cmd>blast<CR>')

-- window
keymap('n', '<Leader>ww', '<C-W>w')
keymap('n', '<Leader>wr', '<C-W>r')
keymap('n', '<Leader>wq', '<C-W>q')
keymap('n', '<Leader>wh', '<C-W>h')
keymap('n', '<Leader>wl', '<C-W>l')
keymap('n', '<Leader>wj', '<C-W>j')
keymap('n', '<Leader>wk', '<C-W>k')
keymap('n', '<Leader>w=', '<C-W>=')
keymap('n', '<Leader>ws', '<C-W>s')
keymap('n', '<Leader>wv', '<C-W>v')
keymap('n', '<C-S-Up>', function() require('smart-splits').resize_up() end)
keymap('n', '<C-S-Down>', function() require('smart-splits').resize_down() end)
keymap('n', '<C-S-Left>', function() require('smart-splits').resize_left() end)
keymap('n', '<C-S-Right>', function() require('smart-splits').resize_right() end)

-- command
keymap('c', '<C-a>', '<Home>')
keymap('c', '<C-e>', '<End>')
keymap('c', '<C-b>', '<S-Left>')
keymap('c', '<C-f>', '<S-Right>')
keymap('c', '<C-h>', '<Left>')
keymap('c', '<C-l>', '<Right>')

-- terminal
keymap('t', '<Esc>', termcodes '<C-\\><C-N>')

--------- plugins key mappings
--- neotree
keymap(
  'n',
  '<Leader>ft',
  '<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<CR>'
)

--- easyalign
keymap('n', 'ga', '<Plug>(EasyAlign)')
keymap('x', 'ga', '<Plug>(EasyAlign)')

--- floaterm
keymap('n', '<Leader>tw', '<cmd>FloatermNew<CR>')
keymap('n', '<C-t>', '<cmd>FloatermToggle<CR>')
keymap('t', '<C-n>', termcodes '<C-\\><C-N>:FloatermNew<CR>')
keymap('t', '<C-k>', termcodes '<C-\\><C-N>:FloatermPrev<CR>')
keymap('t', '<C-j>', termcodes '<C-\\><C-N>:FloatermNext<CR>')
keymap('t', '<C-t>', termcodes '<C-\\><C-N>:FloatermToggle<CR>')
keymap('t', '<C-d>', termcodes '<C-\\><C-N>:FloatermKill<CR>')

--- asynctask
keymap('n', '<C-x>', '<cmd>AsyncTask build-and-run<CR>')
keymap('n', '<C-b>', '<cmd>AsyncTask build<CR>')
keymap('n', '<C-r>', '<cmd>AsyncTask run<CR>')

--- outline
keymap('n', '<Leader>tl', '<cmd>SymbolsOutline<CR>')

--- hop
keymap('n', '<Leader>kk', function() require('hop').hint_lines() end)
keymap('n', '<Leader>jj', function() require('hop').hint_lines() end)
keymap('n', '<Leader>ss', function() require('hop').hint_patterns() end)
keymap(
  'n',
  '<Leader>ll',
  function()
    require('hop').hint_words {
      direction = require('hop.hint').HintDirection.AFTER_CURSOR,
      current_line_only = true,
    }
  end
)
keymap('n', '<Leader>hh',
  function()
    require('hop').hint_words {
      direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
      current_line_only = true,
    }
  end
)

--- accelerate
keymap('n', 'j', '<Plug>(accelerated_jk_gj)')
keymap('n', 'k', '<Plug>(accelerated_jk_gk)')

--- git
keymap('n', '<Leader>hb', function() require('gitsigns').blame_line {full = true} end)
keymap('n', '<Leader>hd', function() require('gitsigns').diffthis() end)

--- markdown
keymap('n', '<Leader>mp', '<cmd>MarkdownPreview<CR>')

--- bufferline
keymap('n', '<Leader>bd', '<cmd>Bdelete<CR>')
keymap('n', '<Leader>1', '<cmd>BufferLineGoToBuffer 1<CR>')
keymap('n', '<Leader>2', '<cmd>BufferLineGoToBuffer 2<CR>')
keymap('n', '<Leader>3', '<cmd>BufferLineGoToBuffer 3<CR>')
keymap('n', '<Leader>4', '<cmd>BufferLineGoToBuffer 4<CR>')
keymap('n', '<Leader>5', '<cmd>BufferLineGoToBuffer 5<CR>')
keymap('n', '<Leader>6', '<cmd>BufferLineGoToBuffer 6<CR>')
keymap('n', '<Leader>7', '<cmd>BufferLineGoToBuffer 7<CR>')
keymap('n', '<Leader>8', '<cmd>BufferLineGoToBuffer 8<CR>')
keymap('n', '<Leader>9', '<cmd>BufferLineGoToBuffer 9<CR>')

--- telescope
keymap('n', '<Leader>ff', function() require('telescope.builtin').find_files() end)
keymap('n', '<Leader>ag', function() require('telescope.builtin').live_grep() end)
keymap('n', '<Leader>Ag', function() require('telescope.builtin').grep_string() end)
keymap('n', '<Leader>bb', function() require('telescope.builtin').buffers() end)
keymap('n', '<Leader>fc', function() require('telescope.builtin').commands() end)
keymap('n', '<Leader>ts', function() require('telescope').extensions.tasks.tasks() end)

-- stylua: ignore end
