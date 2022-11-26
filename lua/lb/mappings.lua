-- =====================================================================
--
-- mappings.lua -
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2022/10/23 17:46
--
-- =====================================================================

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- stylua: ignore start

-- clear default {{{
vim.keymap.set('n', ',', '<Nop>')
vim.keymap.set('n', 'm', '<Nop>')
vim.keymap.set('x', ',', '<Nop>')
vim.keymap.set('x', 'm', '<Nop>')
-- }}}

vim.keymap.set('x', '<Tab>', '>gv|')
vim.keymap.set('x', '<S-Tab>', '<gv')
vim.keymap.set('n', '<Tab>', '>>_')
vim.keymap.set('n', '<S-Tab>', '<<_')

vim.keymap.set("n", "<S-j>", [[:<c-u>execute 'm +'. v:count1<cr>==]], { silent = true, desc = "move lines down" })
vim.keymap.set("n", "<S-k>", [[:<c-u>execute 'm -1-'. v:count1<cr>==]], { silent = true, desc = "move lines up" })
vim.keymap.set("x", "<S-j>", [[:m '>+1<CR><CR>gv=gv]], { silent = true, desc = "move lines down" })
vim.keymap.set("x", "<S-k>", [[:m '<-2<CR><CR>gv=gv]], { silent = true, desc = "move lines up" })

vim.keymap.set("n", "G", "Gzz",     { desc = "auto re-centre when moving around" })
vim.keymap.set("n", "g;", "m'g;zz", { desc = "auto re-centre when moving around" })
vim.keymap.set("n", "g,", "m'g,zz", { desc = "auto re-centre when moving around" })

vim.keymap.set("n", "<Esc><Esc>", ":noh<CR>", { silent = true, desc = "clear hlsearch" })

vim.keymap.set("x", "<", "<gv", { desc = "keep the visually selected area when indenting" })
vim.keymap.set("x", ">", ">gv", { desc = "keep the visually selected area when indenting" })

vim.keymap.set("n", "<leader>hh", ":h <CR>", { desc = "show help for work under the cursor" })

-- Yank related {{{
vim.keymap.set("n", "<Leader>y", '"+y')
vim.keymap.set("x", "<Leader>y", '"+y')
vim.keymap.set("n", "<Leader>p", '"+p')
vim.keymap.set("n", "<Leader>P", '"+P')

vim.keymap.set("x", "p", '"_dP',
  { desc = 'replace visually selected with the " contents' }
)
--}}}

-- bash like {{{
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
-- }}}

-- buffer {{{
vim.keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<Leader>bn', '<cmd>bnext<CR>')
vim.keymap.set('n', '<Leader>bf', '<cmd>bfirst<CR>')
vim.keymap.set('n', '<Leader>bl', '<cmd>blast<CR>')
-- }}}

-- window {{{
vim.keymap.set('n', '<Leader>ww', '<C-W>w')
vim.keymap.set('n', '<Leader>wr', '<C-W>r')
vim.keymap.set('n', '<Leader>wq', '<C-W>q')
vim.keymap.set('n', '<Leader>wh', '<C-W>h')
vim.keymap.set('n', '<Leader>wl', '<C-W>l')
vim.keymap.set('n', '<Leader>wj', '<C-W>j')
vim.keymap.set('n', '<Leader>wk', '<C-W>k')
vim.keymap.set('n', '<Leader>w=', '<C-W>=')
vim.keymap.set('n', '<Leader>ws', '<C-W>s')
vim.keymap.set('n', '<Leader>wv', '<C-W>v')
vim.keymap.set('n', '<C-S-Up>', function() require('smart-splits').resize_up() end)
vim.keymap.set('n', '<C-S-Down>', function() require('smart-splits').resize_down() end)
vim.keymap.set('n', '<C-S-Left>', function() require('smart-splits').resize_left() end)
vim.keymap.set('n', '<C-S-Right>', function() require('smart-splits').resize_right() end)
-- }}}

-- command
-- vim.keymap.set('c', '<C-a>', '<Home>')
-- vim.keymap.set('c', '<C-e>', '<End>')
-- vim.keymap.set('c', '<C-b>', '<S-Left>')
-- vim.keymap.set('c', '<C-f>', '<S-Right>')
-- vim.keymap.set('c', '<C-h>', '<Left>')
-- vim.keymap.set('c', '<C-l>', '<Right>')

-- terminal
vim.keymap.set('t', '<Esc>', termcodes '<C-\\><C-N>')

--------- plugins key mappings
-- neotree
-- vim.keymap.set(
--   'n',
--   '<Leader>ft',
--   '<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<CR>'
-- )

-- vim.keymap.set('n', '<Leader>ft', function() require('nvim-tree').toggle() end)

-- easyalign
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')

-- floaterm
vim.keymap.set('n', '<Leader>tw', '<cmd>FloatermNew<CR>')
vim.keymap.set('n', '<C-t>', '<cmd>FloatermToggle<CR>')
vim.keymap.set('t', '<C-n>', termcodes '<C-\\><C-N>:FloatermNew<CR>')
vim.keymap.set('t', '<C-k>', termcodes '<C-\\><C-N>:FloatermPrev<CR>')
vim.keymap.set('t', '<C-j>', termcodes '<C-\\><C-N>:FloatermNext<CR>')
vim.keymap.set('t', '<C-t>', termcodes '<C-\\><C-N>:FloatermToggle<CR>')
vim.keymap.set('t', '<C-d>', termcodes '<C-\\><C-N>:FloatermKill<CR>')

-- asynctask
vim.keymap.set('n', '<C-x>', '<cmd>AsyncTask build-and-run<CR>')
vim.keymap.set('n', '<C-b>', '<cmd>AsyncTask build<CR>')
vim.keymap.set('n', '<C-r>', '<cmd>AsyncTask run<CR>')

-- outline
vim.keymap.set('n', '<Leader>tl', '<cmd>SymbolsOutline<CR>')

-- hop
vim.keymap.set('n', '<Leader>kk', function() require('hop').hint_lines() end)
vim.keymap.set('n', '<Leader>jj', function() require('hop').hint_lines() end)
vim.keymap.set('n', '<Leader>ss', function() require('hop').hint_patterns() end)
vim.keymap.set(
  'n',
  '<Leader>ll',
  function()
    require('hop').hint_words {
      direction = require('hop.hint').HintDirection.AFTER_CURSOR,
      current_line_only = true,
    }
  end
)
vim.keymap.set('n', '<Leader>hh',
  function()
    require('hop').hint_words {
      direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
      current_line_only = true,
    }
  end
)

-- accelerate
vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)')
vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)')

-- git
vim.keymap.set('n', '<Leader>hb', function() require('gitsigns').blame_line {full = true} end)
vim.keymap.set('n', '<Leader>hd', function() require('gitsigns').diffthis() end)

-- markdown
vim.keymap.set('n', '<Leader>mp', '<cmd>MarkdownPreview<CR>')

-- telescope {{{
vim.keymap.set('n', '<Leader>ff', "<cmd>Telescope find_files<CR>")
vim.keymap.set('n', '<Leader>ag', "<cmd>Telescope live_grep<CR>")
vim.keymap.set('n', '<Leader>Ag', "<cmd>Telescope grep_string<CR>")
vim.keymap.set('n', '<Leader>bb', "<cmd>Telescope buffers<CR>")
vim.keymap.set('n', '<Leader>fc', "<cmd>Telescope command<CR>")
vim.keymap.set('n', '<Leader>ts', "<cmd>Telescope tasks<CR>")
-- }}}

-- stylua: ignore end

-- vim: fdm=marker fdl=0
