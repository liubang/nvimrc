-- =====================================================================
--
-- mappings.lua -
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
-- =====================================================================
-- clear default
vim.keymap.set('n', ',', '', { silent = true })
vim.keymap.set('n', 'm', '', { silent = true })
vim.keymap.set('x', ',', '', { silent = true })
vim.keymap.set('x', 'm', '', { silent = true })

-- better
vim.keymap.set('v', '<Tab>', '>gv|', { silent = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { silent = true })
vim.keymap.set('n', '<Tab>', '>>_', { silent = true })
vim.keymap.set('n', '<S-Tab>', '<<_', { silent = true })
vim.keymap.set('x', '<', '<gv', { silent = true })
vim.keymap.set('x', '>', '>gv', { silent = true })

-- buffer
vim.keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bn', '<cmd>bnext<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bf', '<cmd>bfirst<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bl', '<cmd>blast<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bd', '<cmd>bdelete<CR>', { silent = true })

-- window
vim.keymap.set('n', '<Leader>ww', '<C-W>w', { silent = true })
vim.keymap.set('n', '<Leader>wr', '<C-W>r', { silent = true })
vim.keymap.set('n', '<Leader>wd', '<C-W>d', { silent = true })
vim.keymap.set('n', '<Leader>wq', '<C-W>q', { silent = true })
vim.keymap.set('n', '<Leader>wj', '<C-W>j', { silent = true })
vim.keymap.set('n', '<Leader>wJ', '<C-W>J', { silent = true })
vim.keymap.set('n', '<Leader>wk', '<C-W>k', { silent = true })
vim.keymap.set('n', '<Leader>wK', '<C-W>K', { silent = true })
vim.keymap.set('n', '<Leader>wh', '<C-W>h', { silent = true })
vim.keymap.set('n', '<Leader>wH', '<C-W>H', { silent = true })
vim.keymap.set('n', '<Leader>wl', '<C-W>l', { silent = true })
vim.keymap.set('n', '<Leader>wL', '<C-W>L', { silent = true })
vim.keymap.set('n', '<Leader>w=', '<C-W>=', { silent = true })
vim.keymap.set('n', '<Leader>ws', '<C-W>s', { silent = true })
vim.keymap.set('n', '<Leader>wv', '<C-W>v', { silent = true })
vim.keymap.set('n', '<Leader>w-', '<C-W>5-', { silent = true })
vim.keymap.set('n', '<Leader>w+', '<C-W>5+', { silent = true })
vim.keymap.set('n', '<Leader>w,', '<C-W>5<', { silent = true })
vim.keymap.set('n', '<Leader>w.', '<C-W>5>', { silent = true })

-- bash like
vim.keymap.set('i', '<C-a>', '<Home>', { silent = true })
vim.keymap.set('i', '<C-e>', '<End>', { silent = true })
vim.keymap.set('i', '<C-d>', '<Delete>', { silent = true })

-- command mod
vim.keymap.set('c', '<C-a>', '<Home>', { silent = true })
vim.keymap.set('c', '<C-e>', '<End>', { silent = true })
vim.keymap.set('c', '<C-b>', '<S-Left>', { silent = true })
vim.keymap.set('c', '<C-f>', '<S-right>', { silent = true })
vim.keymap.set('c', '<C-h>', '<Left>', { silent = true })
vim.keymap.set('c', '<C-l>', '<Right>', { silent = true })
vim.keymap.set(
  'c',
  '<C-n>',
  'pumvisible() ? \'<Right>\' : \'<Down>\'',
  { silent = true, expr = true }
)
vim.keymap.set('c', '<C-p>', 'pumvisible() ? \'<Left>\' : \'<Up>\'', { silent = true, expr = true })

-- terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })
vim.keymap.set('t', '<Leader>wh', '<C-\\><C-N><C-w>h', { silent = true })
vim.keymap.set('t', '<Leader>wj', '<C-\\><C-N><C-w>j', { silent = true })
vim.keymap.set('t', '<Leader>wl', '<C-\\><C-N><C-w>l', { silent = true })
vim.keymap.set('t', '<Leader>wk', '<C-\\><C-N><C-w>k', { silent = true })

-- plugins key mappings
vim.keymap.set('n', '<Leader>ft', '<cmd>NvimTreeToggle<CR>', { silent = true })

vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { remap = true })
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { remap = true })

vim.keymap.set('n', '<Leader>tw', '<cmd>FloatermNew<CR>', { silent = true })
vim.keymap.set('n', '<C-t>', '<cmd>FloatermToggle<CR>', { silent = true })
vim.keymap.set('t', '<C-n>', '<C-\\><C-n>:FloatermNew<CR>', { silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n>:FloatermPrev<CR>', { silent = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n>:FloatermNext<CR>', { silent = true })
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true })
vim.keymap.set('t', '<C-d>', '<C-\\><C-n>:FloatermKill<CR>', { silent = true })

vim.keymap.set('n', '<C-x>', '<cmd>AsyncTask file-build-and-run<CR>', { silent = true })
vim.keymap.set('n', '<C-b>', '<cmd>AsyncTask file-build<CR>', { silent = true })
vim.keymap.set('n', '<C-r>', '<cmd>AsyncTask file-run<CR>', { silent = true })

vim.keymap.set('n', '<Leader>tl', '<cmd>SymbolsOutline<CR>', { silent = true })

-- hop
vim.keymap.set('n', '<Leader>kk', function()
  require('hop').hint_lines()
end, { silent = true })

vim.keymap.set('n', '<Leader>jj', function()
  require('hop').hint_lines()
end, { silent = true })

vim.keymap.set('n', '<Leader>ss', function()
  require('hop').hint_patterns()
end, { silent = true })

vim.keymap.set('n', '<Leader>ll', function()
  require('hop').hint_words {
    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
    current_line_only = true,
  }
end, { silent = true })

vim.keymap.set('n', '<Leader>hh', function()
  require('hop').hint_words {
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
    current_line_only = true,
  }
end, { silent = true })

-- accelerate jk
vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', { remap = true })
vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', { remap = true })

-- git
vim.keymap.set('n', '<Leader>hb', function()
  require('gitsigns').blame_line { full = true }
end, { silent = true })

-- markdown
vim.keymap.set('n', '<Leader>mp', '<cmd>MarkdownPreview<CR>', { silent = true })

for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function()
    local cmd = ''
    if require('lb.utils.buffer').is_special_buffer() then
      cmd = '<c-w><c-w>'
    end
    cmd = cmd .. '<cmd>lua require(\'bufferline\').go_to_buffer(' .. i .. ')<CR>'
    return cmd
  end, { expr = true })
end

-- telescope
local telescope_builtin = require 'telescope.builtin'
local telescope_extensions = require('telescope').extensions

vim.keymap.set('n', '<Leader>ff', function()
  telescope_builtin.find_files { previewer = false }
end, { silent = true })
vim.keymap.set('n', '<Leader>ag', telescope_builtin.live_grep, { silent = true })
vim.keymap.set('n', '<Leader>Ag', telescope_builtin.grep_string, { silent = true })
vim.keymap.set('n', '<Leader>bb', function()
  telescope_builtin.buffers { previewer = false }
end, { silent = true })
vim.keymap.set('n', '<Leader>fc', function()
  telescope_builtin.commands { previewer = false }
end, { silent = true })
-- errors
vim.keymap.set('n', '<Leader>es', function()
  telescope_builtin.diagnostics { bufnr = 0 }
end, { silent = true })
-- list symbols
vim.keymap.set('n', '<Leader>ls', telescope_builtin.lsp_document_symbols, { silent = true })
vim.keymap.set('n', '<Leader>ts', telescope_extensions.tasks.tasks, { silent = true })
vim.keymap.set('n', '<Leader>br', telescope_extensions.bazel.bazel_rules, { silent = true })
vim.keymap.set('n', '<Leader>bt', telescope_extensions.bazel.bazel_tests, { silent = true })
vim.keymap.set('n', '<Leader>be', telescope_extensions.bazel.bazel_binaries, { silent = true })
vim.keymap.set('n', '<Leader>wo', function()
  telescope_extensions.project.project { change_dir = true }
end, { silent = true })
