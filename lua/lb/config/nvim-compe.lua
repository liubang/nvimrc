-- =====================================================================
--
-- nvim_compe.lua - 
--
-- Created by liubang on 2021/02/06 00:11
-- Last Modified: 2021/02/06 00:11
--
-- =====================================================================
local nvim_compe = require('compe')
local check_back_space = require('lb.utils.buffer').check_back_space
require('lb.config.snippets')

-- nvim-compe
nvim_compe.setup {
  enabled = true,
  autocomplete = true,
  documentation = false,
  debug = false,
  min_length = 1,
  preselect = 'always',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  allow_prefix_unmatch = false,
  source = {
    path = true,
    calc = true,
    spell = true,
    vsnip = true,
    emoji = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    latex_symbols = true,
    snippets_nvim = true,
  },
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif vim.fn.call('vsnip#available', {1}) == 1 then
    return t '<Plug>(vsnip-expand-or-jump)'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif vim.fn.call('vsnip#jumpable', {-1}) == 1 then
    return t '<Plug>(vsnip-jump-prev)'
  else
    return t '<S-Tab>'
  end
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
