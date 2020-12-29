-- =====================================================================
--
-- mappings.lua - 
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
-- =====================================================================
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  -- rewrite options
  if opts then
    for k, v in pairs(opts) do
      options[k] = v
    end
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function detect(plug)
  -- return true
  return vim.fn['dein#tap'](plug) > 0
end

-- clear default
map('n', ' ', '')
map('x', ' ', '')
map('n', ',', '')
map('x', ',', '')
map('n', ';', '')
map('x', ';', '')
map('n', 'm', '')
map('x', 'm', '')

-- better
map('v', '<Tab>', '>gv|')
map('v', '<S-Tab>', '<gv')
map('n', '<Tab>', '>>_')
map('n', '<S-Tab>', '<<_')

-- buffer
map('n', '<Leader>bp', '<cmd>bprevious<CR>')
map('n', '<Leader>bn', '<cmd>bnext<CR>')
map('n', '<Leader>bf', '<cmd>bfirst<CR>')
map('n', '<Leader>bl', '<cmd>blast<CR>')
map('n', '<Leader>bd', '<cmd>bdelete<CR>')

-- window
map('n', '<Leader>ww', '<C-W>w')
map('n', '<Leader>wr', '<C-W>r')
map('n', '<Leader>wd', '<C-W>d')
map('n', '<Leader>wq', '<C-W>q')
map('n', '<Leader>wj', '<C-W>j')
map('n', '<Leader>wJ', '<C-W>J')
map('n', '<Leader>wk', '<C-W>k')
map('n', '<Leader>wK', '<C-W>K')
map('n', '<Leader>wh', '<C-W>h')
map('n', '<Leader>wH', '<C-W>H')
map('n', '<Leader>wl', '<C-W>l')
map('n', '<Leader>wL', '<C-W>L')
map('n', '<Leader>w=', '<C-W>=')
map('n', '<Leader>ws', '<C-W>s')
map('n', '<Leader>w-', '<C-W>-')
map('n', '<Leader>wv', '<C-W>v')

map('x', '<', '<gv')
map('x', '>', '>gv')

-- bash like
map('i', '<C-a>', '<Home>')
map('i', '<C-e>', '<End>')
map('i', '<C-d>', '<Delete>')

-- command mod
map('c', '<C-a>', '<Home>')
map('c', '<C-e>', '<End>')
map('c', '<C-b>', '<S-Left>')
map('c', '<C-f>', '<S-right>')
map('c', '<C-h>', '<Left>')
map('c', '<C-l>', '<Right>')
map('c', '<C-n>', 'pumvisible() ? \'<Right>\' : \'<Down>\'', {expr = true})
map('c', '<C-p>', 'pumvisible() ? \'<Left>\' : \'<Up>\'', {expr = true})

-- terminal
map('t', '<Esc>', '<C-\\><C-n>')
map('t', '<Leader>wh', '<C-\\><C-N><C-w>h')
map('t', '<Leader>wj', '<C-\\><C-N><C-w>j')
map('t', '<Leader>wl', '<C-\\><C-N><C-w>l')
map('t', '<Leader>wk', '<C-\\><C-N><C-w>k')

-- plugins key mappings
-- LuaFormatter off
if detect('nvim-tree.lua') then
  map('n', "<Leader>ft", "<cmd>lua require('nvim-tree').toggle()<CR>")
end

if detect('caw.vim') then
  map('', "<Leader>cc", "<Plug>(caw:hatpos:toggle)", {noremap = false})
  map('', "<Leader>cw", "<Plug>(caw:wrap:comment)", {noremap = false})
  map('', "<Leader>cu", "<Plug>(caw:wrap:uncomment)", {noremap = false})
  map('', "<Leader>cb", "<Plug>(caw:box:comment)", {noremap = false})
  map('', "<Leader>cp", "<Plug>(caw:jump:comment-prev)", {noremap = false})
  map('', "<Leader>cn", "<Plug>(caw:jump:comment-next)", {noremap = false})
end

if detect('vim-slash') then
  map('', "<plug>(slash-after)", 'zz')
end

if detect('vim-easy-align') then
  map('x', 'ga', "<Plug>(EasyAlign)", {noremap = false})
  map('n', 'ga', "<Plug>(EasyAlign)", {noremap = false})
end

if detect('vim-expand-region') then
  map('v', 'v', "<Plug>(expand_region_expand)", {noremap = false})
  map('v', 'V', "<Plug>(expand_region_shrink)", {noremap = false})
end

if detect('vim-floaterm') then
  map('n', "<Leader>tw", "<cmd>FloatermNew<CR>")
  map('n', "<C-t>", "<cmd>FloatermToggle<CR>")
  map('t', "<C-n>", "<C-\\><C-n>:FloatermNew<CR>")
  map('t', "<C-k>", "<C-\\><C-n>:FloatermPrev<CR>")
  map('t', "<C-j>", "<C-\\><C-n>:FloatermNext<CR>")
  map('t', "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>")
  map('t', "<C-d>", "<C-\\><C-n>:FloatermKill<CR>")
end

if detect('vim-mundo') then
  map('n', "<Leader>ud", "<cmd>MundoToggle<CR>") 
end

if detect('asyncrun.vim') then
  map('n', "<Leader>ar", "<cmd>AsyncRun ")
end

if detect('asynctasks.vim') then
  map('n', "<C-x>", "<cmd>AsyncTask file-build-and-run<CR>")
  map('n', "<C-b>", "<cmd>AsyncTask file-build<CR>")
  map('n', "<C-r>", "<cmd>AsyncTask file-run<CR>")
end

if detect('vista.vim') then
  map('n', "<Leader>tl", "<cmd>Vista!!<CR>")
  map('n', "<Leader>vf", "<cmd>Vista finder coc<CR>")
end


if detect('coc.nvim') then
  map('i', "<TAB>", [[pumvisible() ? "\<C-n>" : v:lua.check_back_space() ? "\<TAB>" : coc#refresh()]], {expr = true}) 
  map('i', "<cr>", [[pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], {expr = true})
  map('i', "<S-TAB>", [[pumvisible() ? "\<C-p>" : "\<C-h>"]], {expr = true})
  map('n', "[g", "<Plug>(coc-diagnostic-prev)", {noremap = false})
  map('n', "]g", "<Plug>(coc-diagnostic-next)", {noremap = false})
  map('n', "<Leader>gd", "<Plug>(coc-definition)", {noremap = false})
  map('n', "<Leader>gD", "<Plug>(coc-declaration)", {noremap = false})
  map('n', "<Leader>gy", "<Plug>(coc-type-definition)", {noremap = false})
  map('n', "<Leader>gi", "<Plug>(coc-implementation)", {noremap = false})
  map('n', "<Leader>gr", "<Plug>(coc-references)", {noremap = false})
  map('n', "<Leader>rn", "<Plug>(coc-rename)", {noremap = false})
  map('n', "<Leader>rf", "<Plug>(coc-refactor)", {noremap = false})
  map('n', "<Leader>ac", "<Plug>(coc-codeaction)", {noremap = false})
  map('n', "<Leader>fm", "<Plug>(coc-format)", {noremap = false})
  map('v', "<Leader>fm", "<Plug>(coc-format-selected)", {noremap =  false})
  map('n', "w", "<Plug>(coc-ci-w)", {noremap = false})
  map('n', "b", "<Plug>(coc-ci-b)", {noremap = false})
end

if detect('markdown-preview.nvim') then
  map('n', "<Leader>mp", "<cmd>MarkdownPreview<CR>")
end

-- if detect('vim-clang-format') then
--   vim.cmd [[autocmd FileType c,cpp,objc nnoremap <silent><buffer><Leader>cf :<C-u>ClangFormat<CR>]] 
--   vim.cmd [[autocmd FileType c,cpp,objc vnoremap <silent><buffer><Leader>cf :ClangFormat<CR>]] 
-- end

-- if detect('lightline-bufferline') then
--   map('n', "<Leader>1", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(1)"]], {noremap = false, expr = true})
--   map('n', "<Leader>2", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(2)"]], {noremap = false, expr = true})
--   map('n', "<Leader>3", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(3)"]], {noremap = false, expr = true})
--   map('n', "<Leader>4", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(4)"]], {noremap = false, expr = true})
--   map('n', "<Leader>5", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(5)"]], {noremap = false, expr = true})
--   map('n', "<Leader>6", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(6)"]], {noremap = false, expr = true})
--   map('n', "<Leader>7", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(7)"]], {noremap = false, expr = true})
--   map('n', "<Leader>8", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(8)"]], {noremap = false, expr = true})
--   map('n', "<Leader>9", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(9)"]], {noremap = false, expr = true})
--   map('n', "<Leader>0", [[(v:lua.is_special_buffer() ? "\<c-w>\<c-w>" : '')."<Plug>lightline#bufferline#go(10)"]], {noremap = false, expr = true})
-- end
-- 
if detect('nvim-bufferline.lua') then
  for i = 1, 9 do
    map('n', "<leader>" .. i, '(v:lua.is_special_buffer() ? "<c-w><c-w>" : "") . ":lua require(\'bufferline\').go_to_buffer(' .. i .. ')<CR>"', {expr = true})
  end
end

if detect('telescope.nvim') then
  map('n', "<Leader>ff", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({previewer = false}))<CR>")
  map('n', "<Leader>ag", ":lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({}))<CR>")
  map('n', "<Leader>Ag", ":lua require('telescope.builtin').grep_string(require('telescope.themes').get_dropdown({}))<CR>")
  map('n', "<Leader>bb", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({previewer = false}))<CR>")
  map('n', "<Leader>fc", ":lua require('telescope.builtin').commands(require('telescope.themes').get_dropdown({previewer = false}))<CR>")
  map('n', "<Leader>fb", ":lua require('telescope.builtin').builtin(require('telescope.themes').get_dropdown({previewer = false}))<CR>")
end
-- LuaFormatter on
