-- =====================================================================
--
-- mappings.lua -
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2022/12/03 01:51
--
-- =====================================================================

-- stylua: ignore start

-- clear default {{{
vim.keymap.set('n', ',', '<Nop>')
vim.keymap.set('n', 'm', '<Nop>')
vim.keymap.set('x', ',', '<Nop>')
vim.keymap.set('x', 'm', '<Nop>')
-- }}}

-- some useful keymaps {{{
vim.keymap.set('x', '<Tab>', '>gv|')
vim.keymap.set('x', '<S-Tab>', '<gv')
vim.keymap.set('n', '<Tab>', '>>_')
vim.keymap.set('n', '<S-Tab>', '<<_')

vim.keymap.set("n", "<S-j>", [[:<c-u>execute 'm +'. v:count1<cr>==]], { silent = true, desc = "move lines down" })
vim.keymap.set("n", "<S-k>", [[:<c-u>execute 'm -1-'. v:count1<cr>==]], { silent = true, desc = "move lines up" })
vim.keymap.set("x", "<S-j>", [[:m '>+1<CR><CR>gv=gv]], { silent = true, desc = "move lines down" })
vim.keymap.set("x", "<S-k>", [[:m '<-2<CR><CR>gv=gv]], { silent = true, desc = "move lines up" })

vim.keymap.set("n", "<Esc><Esc>", ":noh<CR>", { silent = true, desc = "clear hlsearch" })
vim.keymap.set("x", "/", "<Esc>/\\%V", { desc = "Search in visually selected region" })

vim.keymap.set("x", "<", "<gv", { desc = "keep the visually selected area when indenting" })
vim.keymap.set("x", ">", ">gv", { desc = "keep the visually selected area when indenting" })
-- }}}

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
-- }}}

-- terminal {{{
vim.keymap.set('t', '<Esc>', vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true))
-- }}}

-- stylua: ignore end

-- vim: fdm=marker fdl=0
