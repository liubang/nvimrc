-- =====================================================================
--
-- mappings.lua -
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
-- =====================================================================
local keymap = vim.keymap

-- clear default
keymap.set('n', ',', '', { silent = true })
keymap.set('n', 'm', '', { silent = true })
keymap.set('x', ',', '', { silent = true })
keymap.set('x', 'm', '', { silent = true })

-- better
keymap.set('v', '<Tab>', '>gv|', { silent = true })
keymap.set('v', '<S-Tab>', '<gv', { silent = true })
keymap.set('n', '<Tab>', '>>_', { silent = true })
keymap.set('n', '<S-Tab>', '<<_', { silent = true })
keymap.set('x', '<', '<gv', { silent = true })
keymap.set('x', '>', '>gv', { silent = true })

-- buffer
keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>', { silent = true })
keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>', { silent = true })
keymap.set('n', '<Leader>bn', '<cmd>bnext<CR>', { silent = true })
keymap.set('n', '<Leader>bf', '<cmd>bfirst<CR>', { silent = true })
keymap.set('n', '<Leader>bl', '<cmd>blast<CR>', { silent = true })
keymap.set('n', '<Leader>bd', '<cmd>bdelete<CR>', { silent = true })

-- window
keymap.set('n', '<Leader>ww', '<C-W>w', { silent = true })
keymap.set('n', '<Leader>wr', '<C-W>r', { silent = true })
keymap.set('n', '<Leader>wd', '<C-W>d', { silent = true })
keymap.set('n', '<Leader>wq', '<C-W>q', { silent = true })
keymap.set('n', '<Leader>wj', '<C-W>j', { silent = true })
keymap.set('n', '<Leader>wJ', '<C-W>J', { silent = true })
keymap.set('n', '<Leader>wk', '<C-W>k', { silent = true })
keymap.set('n', '<Leader>wK', '<C-W>K', { silent = true })
keymap.set('n', '<Leader>wh', '<C-W>h', { silent = true })
keymap.set('n', '<Leader>wH', '<C-W>H', { silent = true })
keymap.set('n', '<Leader>wl', '<C-W>l', { silent = true })
keymap.set('n', '<Leader>wL', '<C-W>L', { silent = true })
keymap.set('n', '<Leader>w=', '<C-W>=', { silent = true })
keymap.set('n', '<Leader>ws', '<C-W>s', { silent = true })
keymap.set('n', '<Leader>wv', '<C-W>v', { silent = true })
keymap.set('n', '<Leader>w-', '<C-W>5-', { silent = true })
keymap.set('n', '<Leader>w+', '<C-W>5+', { silent = true })
keymap.set('n', '<Leader>w,', '<C-W>5<', { silent = true })
keymap.set('n', '<Leader>w.', '<C-W>5>', { silent = true })

-- bash like
keymap.set('i', '<C-a>', '<Home>', { silent = true })
keymap.set('i', '<C-e>', '<End>', { silent = true })
keymap.set('i', '<C-d>', '<Delete>', { silent = true })

-- command mod
keymap.set('c', '<C-a>', '<Home>', { silent = true })
keymap.set('c', '<C-e>', '<End>', { silent = true })
keymap.set('c', '<C-b>', '<S-Left>', { silent = true })
keymap.set('c', '<C-f>', '<S-right>', { silent = true })
keymap.set('c', '<C-h>', '<Left>', { silent = true })
keymap.set('c', '<C-l>', '<Right>', { silent = true })
keymap.set('c', '<C-n>', 'pumvisible() ? \'<Right>\' : \'<Down>\'', { silent = true, expr = true })
keymap.set('c', '<C-p>', 'pumvisible() ? \'<Left>\' : \'<Up>\'', { silent = true, expr = true })

-- terminal
keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true })
keymap.set('t', '<Leader>wh', '<C-\\><C-N><C-w>h', { silent = true })
keymap.set('t', '<Leader>wj', '<C-\\><C-N><C-w>j', { silent = true })
keymap.set('t', '<Leader>wl', '<C-\\><C-N><C-w>l', { silent = true })
keymap.set('t', '<Leader>wk', '<C-\\><C-N><C-w>k', { silent = true })

-- plugins key mappings

--- NvimTree
keymap.set('n', '<Leader>ft', '<cmd>NvimTreeToggle<CR>', { silent = true })

-- EasyAlign
keymap.set('x', 'ga', '<Plug>(EasyAlign)', { remap = true })
keymap.set('n', 'ga', '<Plug>(EasyAlign)', { remap = true })

-- Floaterm
keymap.set('n', '<Leader>tw', '<cmd>FloatermNew<CR>', { silent = true })
keymap.set('n', '<C-t>', '<cmd>FloatermToggle<CR>', { silent = true })
keymap.set('t', '<C-n>', '<C-\\><C-n>:FloatermNew<CR>', { silent = true })
keymap.set('t', '<C-k>', '<C-\\><C-n>:FloatermPrev<CR>', { silent = true })
keymap.set('t', '<C-j>', '<C-\\><C-n>:FloatermNext<CR>', { silent = true })
keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>', { silent = true })
keymap.set('t', '<C-d>', '<C-\\><C-n>:FloatermKill<CR>', { silent = true })

-- AsyncTask
keymap.set('n', '<C-x>', '<cmd>AsyncTask file-build-and-run<CR>', { silent = true })
keymap.set('n', '<C-b>', '<cmd>AsyncTask file-build<CR>', { silent = true })
keymap.set('n', '<C-r>', '<cmd>AsyncTask file-run<CR>', { silent = true })

-- outline
keymap.set('n', '<Leader>tl', '<cmd>SymbolsOutline<CR>', { silent = true })

-- hop
keymap.set('n', '<Leader>kk', function()
  require('hop').hint_lines()
end, { silent = true })

keymap.set('n', '<Leader>jj', function()
  require('hop').hint_lines()
end, { silent = true })

keymap.set('n', '<Leader>ss', function()
  require('hop').hint_patterns()
end, { silent = true })

keymap.set('n', '<Leader>ll', function()
  require('hop').hint_words {
    direction = require('hop.hint').HintDirection.AFTER_CURSOR,
    current_line_only = true,
  }
end, { silent = true })

keymap.set('n', '<Leader>hh', function()
  require('hop').hint_words {
    direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
    current_line_only = true,
  }
end, { silent = true })

-- accelerate jk
keymap.set('n', 'j', '<Plug>(accelerated_jk_gj)', { remap = true })
keymap.set('n', 'k', '<Plug>(accelerated_jk_gk)', { remap = true })

-- git
local gs = require 'gitsigns'
keymap.set('n', '<Leader>hb', function()
  gs.blame_line { full = true }
end, { silent = true })
keymap.set('n', '<Leader>hd', gs.diffthis, { silent = true })

-- markdown
keymap.set('n', '<Leader>mp', '<cmd>MarkdownPreview<CR>', { silent = true })

-- bufferline
for i = 1, 9 do
  keymap.set('n', '<leader>' .. i, function()
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

keymap.set('n', '<Leader>ff', function()
  telescope_builtin.find_files { previewer = false }
end, { silent = true })
keymap.set('n', '<Leader>ag', telescope_builtin.live_grep, { silent = true })
keymap.set('n', '<Leader>Ag', telescope_builtin.grep_string, { silent = true })
keymap.set('n', '<Leader>bb', function()
  telescope_builtin.buffers { previewer = false }
end, { silent = true })
keymap.set('n', '<Leader>fc', function()
  telescope_builtin.commands { previewer = false }
end, { silent = true })
-- errors
keymap.set('n', '<Leader>es', function()
  telescope_builtin.diagnostics { bufnr = 0 }
end, { silent = true })
-- list symbols
keymap.set('n', '<Leader>ls', telescope_builtin.lsp_document_symbols, { silent = true })
keymap.set('n', '<Leader>ts', telescope_extensions.tasks.tasks, { silent = true })
keymap.set('n', '<Leader>br', telescope_extensions.bazel.bazel_rules, { silent = true })
keymap.set('n', '<Leader>bt', telescope_extensions.bazel.bazel_tests, { silent = true })
keymap.set('n', '<Leader>be', telescope_extensions.bazel.bazel_binaries, { silent = true })
keymap.set('n', '<Leader>wo', function()
  telescope_extensions.project.project { change_dir = true }
end, { silent = true })

-- dap
-- local dap = require 'dap'
-- keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { silent = true })
-- keymap.set('n', '<F5>', dap.continue, { silent = true })
-- keymap.set('n', '<F6>', dap.step_into, { silent = true })
-- keymap.set('n', '<F7>', dap.step_over, { silent = true })
-- keymap.set('n', '<F8>', dap.step_out, { silent = true })
-- keymap.set('n', '<F9>', dap.run_last, { silent = true })
-- keymap.set('n', '<F10>', function()
--   dap.close()
--   require('dap.repl').close()
--   require('dapui').close()
--   vim.cmd 'DapVirtualTextForceRefresh'
-- end, { silent = true })
