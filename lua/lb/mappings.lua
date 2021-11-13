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

-- clear default
map('n', ' ', '')
map('x', ' ', '')
map('n', ',', '')
map('x', ',', '')
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
map('n', '<Leader>wv', '<C-W>v')
map('n', '<Leader>w-', '<C-W>5-')
map('n', '<Leader>w+', '<C-W>5+')
map('n', '<Leader>w,', '<C-W>5<')
map('n', '<Leader>w.', '<C-W>5>')

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

-- insert mod

-- terminal
map('t', '<Esc>', '<C-\\><C-n>')
map('t', '<Leader>wh', '<C-\\><C-N><C-w>h')
map('t', '<Leader>wj', '<C-\\><C-N><C-w>j')
map('t', '<Leader>wl', '<C-\\><C-N><C-w>l')
map('t', '<Leader>wk', '<C-\\><C-N><C-w>k')

-- plugins key mappings
-- LuaFormatter off
map('n', "<Leader>ft", ":NvimTreeToggle<CR>")

-- map('n', "<Leader>cc", ':call nerdcommenter#Comment(\'n\', \'toggle\')<CR>')
-- map('x', "<Leader>cc", ':call nerdcommenter#Comment(\'x\', \'toggle\')<CR>')
-- map('n', "<Leader>cn", ':call nerdcommenter#Comment(\'n\', \'sexy\')<CR>')
-- map('x', "<Leader>cn", ':call nerdcommenter#Comment(\'x\', \'sexy\')<CR>')

map('n', "<Leader>cc", '<Plug>kommentary_line_default', {noremap = false})
map('v', "<Leader>cc", '<Plug>kommentary_visual_default<C-c>', {noremap = false})

map('x', 'ga', "<Plug>(EasyAlign)", {noremap = false})
map('n', 'ga', "<Plug>(EasyAlign)", {noremap = false})

map('v', 'v', "<Plug>(expand_region_expand)", {noremap = false})
map('v', 'V', "<Plug>(expand_region_shrink)", {noremap = false})

map('n', "<Leader>tw", "<cmd>FloatermNew<CR>")
map('n', "<C-t>", "<cmd>FloatermToggle<CR>")
map('t', "<C-n>", "<C-\\><C-n>:FloatermNew<CR>")
map('t', "<C-k>", "<C-\\><C-n>:FloatermPrev<CR>")
map('t', "<C-j>", "<C-\\><C-n>:FloatermNext<CR>")
map('t', "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>")
map('t', "<C-d>", "<C-\\><C-n>:FloatermKill<CR>")

map('n', "<Leader>ud", "<cmd>MundoToggle<CR>") 

map('n', "<Leader>ar", "<cmd>AsyncRun ")

map('n', "<C-x>", "<cmd>AsyncTask file-build-and-run<CR>")
map('n', "<C-b>", "<cmd>AsyncTask file-build<CR>")
map('n', "<C-r>", "<cmd>AsyncTask file-run<CR>")

map('n', "<Leader>tl", "<cmd>Vista!!<CR>")

-- hop
map('n', '<Leader>kk', ":lua require('hop').hint_lines()<CR>")
map('n', '<Leader>jj', ":lua require('hop').hint_lines()<CR>")
map('n', '<Leader>ss', ":lua require('hop').hint_patterns()<CR>")

map('n', "<Leader>mp", "<cmd>MarkdownPreview<CR>")

for i = 1, 9 do
  map('n', "<leader>" .. i, '(v:lua.is_special_buffer() ? "<c-w><c-w>" : "") . ":lua require(\'bufferline\').go_to_buffer(' .. i .. ')<CR>"', {expr = true})
end

map('n', "<Leader>ff", ":lua require('telescope.builtin').find_files({previewer = false})<CR>")
map('n', "<Leader>ag", ":lua require('telescope.builtin').live_grep()<CR>")
map('n', "<Leader>Ag", ":lua require('telescope.builtin').grep_string()<CR>")
map('n', "<Leader>bb", ":lua require('telescope.builtin').buffers({previewer = false})<CR>")
map('n', "<Leader>fc", ":lua require('telescope.builtin').commands({previewer = false})<CR>")
map('n', "<Leader>fb", ":lua require('telescope.builtin').builtin({previewer = false})<CR>")
-- list symbols
map('n', "<Leader>ls", ":lua require('telescope.builtin').lsp_document_symbols()<CR>")
map('n', "<Leader>ts", ":lua require('telescope').extensions.tasks.tasks()<CR>")
map('n', "<Leader>br", ":lua require('telescope').extensions.bazel.bazel_rules()<CR>")
map('n', "<Leader>bt", ":lua require('telescope').extensions.bazel.bazel_tests()<CR>")
map('n', "<Leader>be", ":lua require('telescope').extensions.bazel.bazel_binaries()<CR>")
map('n', "<Leader>wo", ":lua require('telescope').extensions.project.project({change_dir = true})<CR>")
-- LuaFormatter on
