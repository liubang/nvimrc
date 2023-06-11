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

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })


-- Move Lines
vim.keymap.set("n", "<S-j>", [[:<c-u>execute 'm +'. v:count1<cr>==]], { silent = true, desc = "Move lines down" })
vim.keymap.set("n", "<S-k>", [[:<c-u>execute 'm -1-'. v:count1<cr>==]], { silent = true, desc = "Move lines up" })
vim.keymap.set("x", "<S-j>", [[:m '>+1<CR><CR>gv=gv]], { silent = true, desc = "Move lines down" })
vim.keymap.set("x", "<S-k>", [[:m '<-2<CR><CR>gv=gv]], { silent = true, desc = "Move lines up" })

vim.keymap.set("n", "<Esc><Esc>", ":noh<CR>", { silent = true, desc = "Clear hlsearch" })
vim.keymap.set("x", "/", "<Esc>/\\%V", { desc = "Search in visually selected region" })

vim.keymap.set("x", "<", "<gv", { desc = "Keep the visually selected area when indenting" })
vim.keymap.set("x", ">", ">gv", { desc = "Keep the visually selected area when indenting" })
-- }}}

-- Yank related {{{
vim.keymap.set("n", "<Leader>y", '"+y')
vim.keymap.set("x", "<Leader>y", '"+y')
vim.keymap.set("n", "<Leader>p", '"+p')
vim.keymap.set("n", "<Leader>P", '"+P')

vim.keymap.set("x", "p", '"_dP',
  { desc = 'Rreplace visually selected with the " contents' }
)
--}}}

-- bash like {{{
vim.keymap.set('i', '<C-a>', '<Home>')
vim.keymap.set('i', '<C-e>', '<End>')
-- }}}

-- buffer {{{
vim.keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>', { desc = "Previous" })
vim.keymap.set('n', '<Leader>bn', '<cmd>bnext<CR>', { desc = "Next" })
vim.keymap.set('n', '<Leader>bf', '<cmd>bfirst<CR>', { desc = "First" })
vim.keymap.set('n', '<Leader>bl', '<cmd>blast<CR>',{ desc = "Last" })
-- }}}

-- window {{{
vim.keymap.set('n', '<Leader>ww', '<C-W>w', { desc = "Toggle between open windows" })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
vim.keymap.set('n', '<Leader>wr', '<C-W>r')
vim.keymap.set('n', '<Leader>wq', '<C-W>q')
vim.keymap.set('n', '<Leader>wh', '<C-W>h', { desc = "Move to the left window" })
vim.keymap.set('n', '<Leader>wl', '<C-W>l', { desc = "Move to the right window" })
vim.keymap.set('n', '<Leader>wj', '<C-W>j', { desc = "Move to the bottom window" })
vim.keymap.set('n', '<Leader>wk', '<C-W>k', { desc = "Move to the top window" })
vim.keymap.set('n', '<Leader>w=', '<C-W>=')
vim.keymap.set('n', '<Leader>ws', '<C-W>s', { desc = "Split window horizontally" })
vim.keymap.set('n', '<Leader>wv', '<C-W>v', { desc = "Split window vertically" })
-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- }}}

-- terminal {{{
vim.keymap.set('t', '<Esc>', vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true))
-- }}}

-- stylua: ignore end

-- vim: fdm=marker fdl=0
