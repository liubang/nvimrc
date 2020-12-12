--=====================================================================
--
-- mappings.lua - 
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
--=====================================================================

local keymap = vim.api.nvim_set_keymap

keymap('n', ' ', '', {noremap = true})
keymap('x', ' ', '', {noremap = true})
keymap('n', ',', '', {noremap = true})
keymap('x', ',', '', {noremap = true})
keymap('n', ';', '', {noremap = true})
keymap('x', ';', '', {noremap = true})
keymap('n', 'm', '', {noremap = true})
keymap('x', 'm', '', {noremap = true})

keymap('v', "<Tab>", '>gv|', {noremap = true, silent = true})
keymap('v', "<S-Tab>", '<gv', {noremap = true, silent = true})
keymap('n', "<Tab>", '>>_', {noremap = true, silent = true})
keymap('n', "<S-Tab>", '<<_', {noremap = true, silent = true})

-- buffer
keymap('n', "<Leader>bp", "<cmd>bprevious<CR>", {noremap = true, silent = true})
keymap('n', "<Leader>bn", "<cmd>bnext<cr>", {noremap = true, silent = true})
keymap('n', "<Leader>bf", "<cmd>bfirst<cr>", {noremap = true, silent = true})
keymap('n', "<Leader>bl", "<cmd>blast<cr>", {noremap = true, silent = true})
keymap('n', "<Leader>bd", "<cmd>bdelete<cr>", {noremap = true, silent = true})

-- window
keymap('n', "<Leader>ww", "<C-W>w", {noremap = true, silent = true})
keymap('n', "<Leader>wr", "<C-W>r", {noremap = true, silent = true})
keymap('n', "<Leader>wd", "<C-W>d", {noremap = true, silent = true})
keymap('n', "<Leader>wq", "<C-W>q", {noremap = true, silent = true})
keymap('n', "<Leader>wj", "<C-W>j", {noremap = true, silent = true})
keymap('n', "<Leader>wJ", "<C-W>J", {noremap = true, silent = true})
keymap('n', "<Leader>wk", "<C-W>k", {noremap = true, silent = true})
keymap('n', "<Leader>wK", "<C-W>K", {noremap = true, silent = true})
keymap('n', "<Leader>wh", "<C-W>h", {noremap = true, silent = true})
keymap('n', "<Leader>wH", "<C-W>H", {noremap = true, silent = true})
keymap('n', "<Leader>wl", "<C-W>l", {noremap = true, silent = true})
keymap('n', "<Leader>wL", "<C-W>L", {noremap = true, silent = true})
keymap('n', "<Leader>w=", "<C-W>=", {noremap = true, silent = true})
keymap('n', "<Leader>ws", "<C-W>s", {noremap = true, silent = true})
keymap('n', "<Leader>w-", "<C-W>-", {noremap = true, silent = true})
keymap('n', "<Leader>wv", "<C-W>v", {noremap = true, silent = true})

keymap('x', "<", "<gv", {noremap = true, silent = true})
keymap('x', ">", ">gv", {noremap = true, silent = true})

-- bash like
keymap('i', "<C-a>", "<Home>", {noremap = true, silent = true})
keymap('i', "<C-e>", "<End>", {noremap = true, silent = true})
keymap('i', "<C-d>", "<Delete>", {noremap = true, silent = true})

-- command mod
keymap('c', "<C-a>", "<Home>", {noremap = true, silent = true})
keymap('c', "<C-e>", "<End>", {noremap = true, silent = true})
keymap('c', "<C-b>", "<S-Left>", {noremap = true, silent = true})
keymap('c', "<C-f>", "<S-right>", {noremap = true, silent = true})
keymap('c', "<C-h>", "<Left>", {noremap = true, silent = true})
keymap('c', "<C-l>", "<Right>", {noremap = true, silent = true})
keymap('c', "<C-n>", "pumvisible() ? '<Right>' : '<Down>'", {noremap = true, expr = true})
keymap('c', "<C-p>", "pumvisible() ? '<Left>' : '<Up>'", {noremap = true, expr = true})

-- terminal
keymap('t', "<Esc>", "<C-\\><C-n>", {noremap = true, silent = true})
keymap('t', "<Leader>wh", "<C-\\><C-N><C-w>h", {noremap = true, silent = true})
keymap('t', "<Leader>wj", "<C-\\><C-N><C-w>j", {noremap = true, silent = true})
keymap('t', "<Leader>wl", "<C-\\><C-N><C-w>l", {noremap = true, silent = true})
keymap('t', "<Leader>wk", "<C-\\><C-N><C-w>k", {noremap = true, silent = true})

-- plugins key mappings
if vim.fn['dein#tap']('nvim-tree.lua') then
  keymap('n', "<Leader>ft", "<cmd>lua require('tree').toggle()<cr>", {noremap = true, silent = true})
end

if vim.fn['dein#tap']('caw.vim') then
  keymap('n', "<Leader>cc", "<Plug>(caw:hatpos:toggle)", {noremap = false, silent = true})
  keymap('n', "<Leader>cw", "<Plug>(caw:wrap:comment)", {noremap = false, silent = true})
  keymap('n', "<Leader>cu", "<Plug>(caw:wrap:uncomment)", {noremap = false, silent = true})
  keymap('n', "<Leader>cb", "<Plug>(caw:box:comment)", {noremap = false, silent = true})
  keymap('n', "<Leader>cp", "<Plug>(caw:jump:comment-prev)", {noremap = false, silent = true})
  keymap('n', "<Leader>cn", "<Plug>(caw:jump:comment-next)", {noremap = false, silent = true})
end

if vim.fn['dein#tap']('vim-slash') then
  keymap('', "<plug>(slash-after)", 'zz', {noremap = true, silent = true})
end

if vim.fn['dein#tap']('vim-easy-align') then
  keymap('x', 'ga', "<Plug>(EasyAlign)", {noremap = false, silent = true})
  keymap('n', 'ga', "<Plug>(EasyAlign)", {noremap = false, silent = true})
end

if vim.fn['dein#tap']('vim-expand-region') then
  keymap('v', 'v', "<Plug>(expand_region_expand)", {noremap = false, silent = true})
  keymap('v', 'V', "<Plug>(expand_region_shrink)", {noremap = false, silent = true})
end

if vim.fn['dein#tap']('vim-floaterm') then
  keymap('n', "<Leader>tw", "<cmd>FloatermNew<cr>", {noremap = true, silent = true})
  keymap('n', "<C-t>", "<cmd>FloatermToggle<cr>", {noremap = true, silent = true})
  keymap('t', "<C-n>", "<C-\\><C-n>:FloatermNew<cr>", {noremap = true, silent = true})
  keymap('t', "<C-k>", "<C-\\><C-n>:FloatermPrev<cr>", {noremap = true, silent = true})
  keymap('t', "<C-j>", "<C-\\><C-n>:FloatermNext<cr>", {noremap = true, silent = true})
  keymap('t', "<C-t>", "<C-\\><C-n>:FloatermToggle<cr>", {noremap = true, silent = true})
  keymap('t', "<C-d>", "<C-\\><C-n>:FloatermKill<cr>", {noremap = true, silent = true})
end

if vim.fn['dein#tap']('vim-mundo') then
  keymap('n', "<Leader>ud", "<cmd>MundoToggle<cr>", {noremap = true, silent = true}) 
end

if vim.fn['dein#tap']('asyncrun.vim') then
  keymap('n', "<Leader>ar", "<cmd>AsyncRun ", {noremap = true, silent = true})
end

if vim.fn['dein#tap']('asynctasks.vim') then
  keymap('n', "<C-x>", "<cmd>AsyncTask file-build-and-run<cr>", {noremap = true, silent = true})
  keymap('n', "<C-b>", "<cmd>AsyncTask file-build<cr>", {noremap = true, silent = true})
  keymap('n', "<C-r>", "<cmd>AsyncTask file-run<cr>", {noremap = true, silent = true})
end

if vim.fn['dein#tap']('vista.vim') then
  keymap('n', "<Leader>tl", "<cmd>Vista!!<cr>", {noremap = true, silent = true})
  keymap('n', "<Leader>vf", "<cmd>Vista finder coc<cr>", {noremap = true, silent = true})
end

function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

if vim.fn['dein#tap']('coc.nvim') then
  keymap('i', "<TAB>", [[pumvisible() ? "\<C-n>" : v:lua.check_back_space() ? "\<TAB>" : coc#refresh()]], {noremap = true, silent = true, expr = true}) 
  keymap('i', "<S-TAB>", [[pumvisible() ? "\<C-p>" : "\<C-h>"]], {noremap = true, silent = true, expr = true})
  keymap('n', "[g", "<Plug>(coc-diagnostic-prev)", {noremap = false, silent = true})
  keymap('n', "]g", "<Plug>(coc-diagnostic-next)", {noremap = false, silent = true})
  keymap('n', "gd", "<Plug>(coc-definition)", {noremap = false, silent = true})
  keymap('n', "gD", "<Plug>(coc-declaration)", {noremap = false, silent = true})
  keymap('n', "gy", "<Plug>(coc-type-definition)", {noremap = false, silent = true})
  keymap('n', "gi", "<Plug>(coc-implementation)", {noremap = false, silent = true})
  keymap('n', "gr", "<Plug>(coc-references)", {noremap = false, silent = true})
  keymap('n', "rn", "<Plug>(coc-rename)", {noremap = false, silent = true})
  keymap('n', "rf", "<Plug>(coc-refactor)", {noremap = false, silent = true})
  keymap('n', "w", "<Plug>(coc-ci-w)", {noremap = false, silent = true})
  keymap('n', "b", "<Plug>(coc-ci-b)", {noremap = false, silent = true})
  keymap('n', "fm", "<cmd>call CocAction('format')<cr>", {noremap = true, silent = true})
end

if vim.fn['dein#tap']('markdown-preview.nvim') then
  keymap('n', "<Leader>mp", "<cmd>MarkdownPreview<cr>", {noremap = true, silent = true})
end

if vim.fn['dein#tap']('vim-clang-format') then
  vim.cmd [[autocmd FileType c,cpp,objc nnoremap <silent><buffer><Leader>cf :<C-u>ClangFormat<CR>]] 
  vim.cmd [[autocmd FileType c,cpp,objc vnoremap <silent><buffer><Leader>cf :ClangFormat<CR>]] 
end

if vim.fn['dein#tap']('lightline-bufferline') then
  keymap('n', "<Leader>1", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>2", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>3", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>4", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>5", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>6", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>7", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>8", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>9", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"]], {noremap = false, expr = true, silent = true})
  keymap('n', "<Leader>0", [[(utils#is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"]], {noremap = false, expr = true, silent = true})
end

if vim.fn['dein#tap']('telescope.nvim') then
  keymap('n', "<Leader>ff", "<cmd>Telescope find_files<CR>", {noremap = true, silent = true})
  keymap('n', "<Leader>ag", "<cmd>Telescope live_grep<CR>", {noremap = true, silent = true})
  keymap('n', "<Leader>Ag", "<cmd>Telescope grep_string<CR>", {noremap = true, silent = true})
  keymap('n', "<Leader>bb", "<cmd>Telescope buffers<CR>", {noremap = true, silent = true})
  keymap('n', "<Leader>fc", "<cmd>Telescope commands<CR>", {noremap = true, silent = true})
  keymap('n', "<Leader>fb", "<cmd>Telescope builtin<CR>", {noremap = true, silent = true})
end
