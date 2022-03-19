-- =====================================================================
--
-- mappings.lua -
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
-- =====================================================================
-- clear default
vim.keymap.set('n', ',', '', { remap = true })
vim.keymap.set('n', 'm', '', { remap = true })
vim.keymap.set('x', ',', '', { remap = true })
vim.keymap.set('x', 'm', '', { remap = true })

-- better
vim.keymap.set('v', '<Tab>', '>gv|', { remap = true })
vim.keymap.set('v', '<S-Tab>', '<gv', { remap = true })
vim.keymap.set('n', '<Tab>', '>>_', { remap = true })
vim.keymap.set('n', '<S-Tab>', '<<_', { remap = true })
vim.keymap.set('x', '<', '<gv', { remap = true })
vim.keymap.set('x', '>', '>gv', { remap = true })

-- buffer
vim.keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>', { remap = true })
vim.keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>', { remap = true })
vim.keymap.set('n', '<Leader>bn', '<cmd>bnext<CR>', { remap = true })
vim.keymap.set('n', '<Leader>bf', '<cmd>bfirst<CR>', { remap = true })
vim.keymap.set('n', '<Leader>bl', '<cmd>blast<CR>', { remap = true })
vim.keymap.set('n', '<Leader>bd', '<cmd>bdelete<CR>', { remap = true })

-- window
vim.keymap.set('n', '<Leader>ww', '<C-W>w', { remap = true })
vim.keymap.set('n', '<Leader>wr', '<C-W>r', { remap = true })
vim.keymap.set('n', '<Leader>wd', '<C-W>d', { remap = true })
vim.keymap.set('n', '<Leader>wq', '<C-W>q', { remap = true })
vim.keymap.set('n', '<Leader>wj', '<C-W>j', { remap = true })
vim.keymap.set('n', '<Leader>wJ', '<C-W>J', { remap = true })
vim.keymap.set('n', '<Leader>wk', '<C-W>k', { remap = true })
vim.keymap.set('n', '<Leader>wK', '<C-W>K', { remap = true })
vim.keymap.set('n', '<Leader>wh', '<C-W>h', { remap = true })
vim.keymap.set('n', '<Leader>wH', '<C-W>H', { remap = true })
vim.keymap.set('n', '<Leader>wl', '<C-W>l', { remap = true })
vim.keymap.set('n', '<Leader>wL', '<C-W>L', { remap = true })
vim.keymap.set('n', '<Leader>w=', '<C-W>=', { remap = true })
vim.keymap.set('n', '<Leader>ws', '<C-W>s', { remap = true })
vim.keymap.set('n', '<Leader>wv', '<C-W>v', { remap = true })
vim.keymap.set('n', '<Leader>w-', '<C-W>5-', { remap = true })
vim.keymap.set('n', '<Leader>w+', '<C-W>5+', { remap = true })
vim.keymap.set('n', '<Leader>w,', '<C-W>5<', { remap = true })
vim.keymap.set('n', '<Leader>w.', '<C-W>5>', { remap = true })

-- bash like
vim.keymap.set('i', '<C-a>', '<Home>', { remap = true })
vim.keymap.set('i', '<C-e>', '<End>', { remap = true })
vim.keymap.set('i', '<C-d>', '<Delete>', { remap = true })

-- command mod
vim.keymap.set('c', '<C-a>', '<Home>', { remap = true })
vim.keymap.set('c', '<C-e>', '<End>', { remap = true })
vim.keymap.set('c', '<C-b>', '<S-Left>', { remap = true })
vim.keymap.set('c', '<C-f>', '<S-right>', { remap = true })
vim.keymap.set('c', '<C-h>', '<Left>', { remap = true })
vim.keymap.set('c', '<C-l>', '<Right>', { remap = true })
vim.keymap.set(
  'c',
  '<C-n>',
  'pumvisible() ? \'<Right>\' : \'<Down>\'',
  { remap = true, expr = true }
)
vim.keymap.set('c', '<C-p>', 'pumvisible() ? \'<Left>\' : \'<Up>\'', { remap = true, expr = true })

-- terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { remap = true })
vim.keymap.set('t', '<Leader>wh', '<C-\\><C-N><C-w>h', { remap = true })
vim.keymap.set('t', '<Leader>wj', '<C-\\><C-N><C-w>j', { remap = true })
vim.keymap.set('t', '<Leader>wl', '<C-\\><C-N><C-w>l', { remap = true })
vim.keymap.set('t', '<Leader>wk', '<C-\\><C-N><C-w>k', { remap = true })

-- plugins key mappings
vim.keymap.set('n', '<Leader>ft', '<cmd>NvimTreeToggle<CR>', { remap = true })

vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')

vim.keymap.set('n', '<Leader>tw', '<cmd>FloatermNew<CR>', { remap = true })
vim.keymap.set('n', '<C-t>', '<cmd>FloatermToggle<CR>', { remap = true })
vim.keymap.set('t', '<C-n>', '<C-\\><C-n>:FloatermNew<CR>', { remap = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n>:FloatermPrev<CR>', { remap = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n>:FloatermNext<CR>', { remap = true })
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>', { remap = true })
vim.keymap.set('t', '<C-d>', '<C-\\><C-n>:FloatermKill<CR>', { remap = true })

vim.keymap.set('n', '<C-x>', '<cmd>AsyncTask file-build-and-run<CR>', { remap = true })
vim.keymap.set('n', '<C-b>', '<cmd>AsyncTask file-build<CR>', { remap = true })
vim.keymap.set('n', '<C-r>', '<cmd>AsyncTask file-run<CR>', { remap = true })

vim.keymap.set('n', '<Leader>tl', '<cmd>SymbolsOutline<CR>', { remap = true })

-- hop
vim.keymap.set('n', '<Leader>kk', function()
  require('hop').hint_lines()
end, { remap = true })

vim.keymap.set('n', '<Leader>jj', function()
  require('hop').hint_lines()
end, { remap = true })

vim.keymap.set('n', '<Leader>ss', function()
  require('hop').hint_patterns()
end, { remap = true })

vim.keymap.set('n', '<Leader>ll', function()
  require('hop').hint_words {
    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
    current_line_only = true,
  }
end, { remap = true })

vim.keymap.set('n', '<Leader>hh', function()
  require('hop').hint_words {
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
    current_line_only = true,
  }
end, { remap = true })

-- accelerate jk
vim.keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)')
vim.keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)')

-- git
vim.keymap.set('n', '<Leader>hb', function()
  require('gitsigns').blame_line { full = true }
end, { remap = true })

-- markdown
vim.keymap.set('n', '<Leader>mp', '<cmd>MarkdownPreview<CR>', { remap = true })

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
end, { remap = true })
vim.keymap.set('n', '<Leader>ag', telescope_builtin.live_grep, { remap = true })
vim.keymap.set('n', '<Leader>Ag', telescope_builtin.grep_string, { remap = true })
vim.keymap.set('n', '<Leader>bb', function()
  telescope_builtin.buffers { previewer = false }
end, { remap = true })
vim.keymap.set('n', '<Leader>fc', function()
  telescope_builtin.commands { previewer = false }
end, { remap = true })
-- errors
vim.keymap.set('n', '<Leader>es', function()
  telescope_builtin.diagnostics { bufnr = 0 }
end, { remap = true })
-- list symbols
vim.keymap.set('n', '<Leader>ls', telescope_builtin.lsp_document_symbols, { remap = true })
vim.keymap.set('n', '<Leader>ts', telescope_extensions.tasks.tasks, { remap = true })
vim.keymap.set('n', '<Leader>br', telescope_extensions.bazel.bazel_rules, { remap = true })
vim.keymap.set('n', '<Leader>bt', telescope_extensions.bazel.bazel_tests, { remap = true })
vim.keymap.set('n', '<Leader>be', telescope_extensions.bazel.bazel_binaries, { remap = true })
vim.keymap.set('n', '<Leader>wo', function()
  telescope_extensions.project.project { change_dir = true }
end, { remap = true })
