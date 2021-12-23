-- =====================================================================
--
-- mappings.lua -
--
-- Created by liubang on 2020/12/12 12:56
-- Last Modified: 2020/12/12 12:56
--
-- =====================================================================
local nnoremap = vim.keymap.nnoremap
local vnoremap = vim.keymap.vnoremap
local xnoremap = vim.keymap.xnoremap
local inoremap = vim.keymap.inoremap
local cnoremap = vim.keymap.cnoremap
local tnoremap = vim.keymap.tnoremap
local nmap = vim.keymap.nmap
local xmap = vim.keymap.xmap
-- local vmap = vim.keymap.vmap

-- clear default
nnoremap { ',', '' }
nnoremap { 'm', '' }
xnoremap { ',', '' }
xnoremap { 'm', '' }

-- better
vnoremap { '<Tab>', '>gv|' }
vnoremap { '<S-Tab>', '<gv' }
nnoremap { '<Tab>', '>>_' }
nnoremap { '<S-Tab>', '<<_' }

-- buffer
nnoremap { '<Leader>bp', '<cmd>bprevious<CR>' }
nnoremap { '<Leader>bp', '<cmd>bprevious<CR>' }
nnoremap { '<Leader>bn', '<cmd>bnext<CR>' }
nnoremap { '<Leader>bf', '<cmd>bfirst<CR>' }
nnoremap { '<Leader>bl', '<cmd>blast<CR>' }
nnoremap { '<Leader>bd', '<cmd>bdelete<CR>' }

-- window
nnoremap { '<Leader>ww', '<C-W>w' }
nnoremap { '<Leader>wr', '<C-W>r' }
nnoremap { '<Leader>wd', '<C-W>d' }
nnoremap { '<Leader>wq', '<C-W>q' }
nnoremap { '<Leader>wj', '<C-W>j' }
nnoremap { '<Leader>wJ', '<C-W>J' }
nnoremap { '<Leader>wk', '<C-W>k' }
nnoremap { '<Leader>wK', '<C-W>K' }
nnoremap { '<Leader>wh', '<C-W>h' }
nnoremap { '<Leader>wH', '<C-W>H' }
nnoremap { '<Leader>wl', '<C-W>l' }
nnoremap { '<Leader>wL', '<C-W>L' }
nnoremap { '<Leader>w=', '<C-W>=' }
nnoremap { '<Leader>ws', '<C-W>s' }
nnoremap { '<Leader>wv', '<C-W>v' }
nnoremap { '<Leader>w-', '<C-W>5-' }
nnoremap { '<Leader>w+', '<C-W>5+' }
nnoremap { '<Leader>w,', '<C-W>5<' }
nnoremap { '<Leader>w.', '<C-W>5>' }

xnoremap { '<', '<gv' }
xnoremap { '>', '>gv' }

-- bash like
inoremap { '<C-a>', '<Home>' }
inoremap { '<C-e>', '<End>' }
inoremap { '<C-d>', '<Delete>' }

-- command mod
cnoremap { '<C-a>', '<Home>' }
cnoremap { '<C-e>', '<End>' }
cnoremap { '<C-b>', '<S-Left>' }
cnoremap { '<C-f>', '<S-right>' }
cnoremap { '<C-h>', '<Left>' }
cnoremap { '<C-l>', '<Right>' }
cnoremap { '<C-n>', 'pumvisible() ? \'<Right>\' : \'<Down>\'', expr = true }
cnoremap { '<C-p>', 'pumvisible() ? \'<Left>\' : \'<Up>\'', expr = true }

-- terminal
tnoremap { '<Esc>', '<C-\\><C-n>' }
tnoremap { '<Leader>wh', '<C-\\><C-N><C-w>h' }
tnoremap { '<Leader>wj', '<C-\\><C-N><C-w>j' }
tnoremap { '<Leader>wl', '<C-\\><C-N><C-w>l' }
tnoremap { '<Leader>wk', '<C-\\><C-N><C-w>k' }

-- plugins key mappings
nnoremap { '<Leader>ft', '<cmd>NvimTreeToggle<CR>' }

-- nmap { '<Leader>cc', '<Plug>kommentary_line_default' }
-- vmap { '<Leader>cc', '<Plug>kommentary_visual_default<C-c>' }

xmap { 'ga', '<Plug>(EasyAlign)' }
nmap { 'ga', '<Plug>(EasyAlign)' }

-- vmap { 'v', '<Plug>(expand_region_expand)' }
-- vmap { 'V', '<Plug>(expand_region_shrink)' }

nnoremap { '<Leader>tw', '<cmd>FloatermNew<CR>' }
nnoremap { '<C-t>', '<cmd>FloatermToggle<CR>' }
tnoremap { '<C-n>', '<C-\\><C-n>:FloatermNew<CR>' }
tnoremap { '<C-k>', '<C-\\><C-n>:FloatermPrev<CR>' }
tnoremap { '<C-j>', '<C-\\><C-n>:FloatermNext<CR>' }
tnoremap { '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>' }
tnoremap { '<C-d>', '<C-\\><C-n>:FloatermKill<CR>' }

-- nnoremap { '<Leader>ud', '<cmd>MundoToggle<CR>' }

nnoremap { '<C-x>', '<cmd>AsyncTask file-build-and-run<CR>' }
nnoremap { '<C-b>', '<cmd>AsyncTask file-build<CR>' }
nnoremap { '<C-r>', '<cmd>AsyncTask file-run<CR>' }

nnoremap { '<Leader>tl', '<cmd>SymbolsOutline<CR>' }

-- hop
nnoremap { '<Leader>kk', ':lua require(\'hop\').hint_lines()<CR>' }
nnoremap { '<Leader>jj', ':lua require(\'hop\').hint_lines()<CR>' }
nnoremap { '<Leader>ss', ':lua require(\'hop\').hint_patterns()<CR>' }

-- git
nnoremap {
  '<Leader>hb',
  function()
    require('gitsigns').blame_line { full = true }
  end,
}

-- markdown
nnoremap { '<Leader>mp', '<cmd>MarkdownPreview<CR>' }

for i = 1, 9 do
  nmap {
    '<leader>' .. i,
    function()
      local cmd = ''
      if require('lb.utils.buffer').is_special_buffer() then
        cmd = '<c-w><c-w>'
      end
      cmd = cmd .. '<cmd>lua require(\'bufferline\').go_to_buffer(' .. i .. ')<CR>'
      return cmd
    end,
    expr = true,
  }
end

-- telescope
local telescope_builtin = require 'telescope.builtin'
local telescope_extensions = require('telescope').extensions

nnoremap {
  '<Leader>ff',
  function()
    telescope_builtin.find_files { previewer = false }
  end,
}
nnoremap { '<Leader>ag', telescope_builtin.live_grep }
nnoremap { '<Leader>Ag', telescope_builtin.grep_string }
nnoremap {
  '<Leader>bb',
  function()
    telescope_builtin.buffers { previewer = false }
  end,
}
nnoremap {
  '<Leader>fc',
  function()
    telescope_builtin.commands { previewer = false }
  end,
}
nnoremap {
  '<Leader>fb',
  function()
    telescope_builtin.builtin { previewer = false }
  end,
}
-- list symbols
nnoremap { '<Leader>ls', telescope_builtin.lsp_document_symbols }
nnoremap { '<Leader>ts', telescope_extensions.tasks.tasks }
nnoremap { '<Leader>br', telescope_extensions.bazel.bazel_rules }
nnoremap { '<Leader>bt', telescope_extensions.bazel.bazel_tests }
nnoremap { '<Leader>be', telescope_extensions.bazel.bazel_binaries }
nnoremap {
  '<Leader>wo',
  function()
    telescope_extensions.project.project { change_dir = true }
  end,
}
