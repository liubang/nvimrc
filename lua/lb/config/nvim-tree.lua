-- =====================================================================
--
-- nvim-tree.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================
local g, api = vim.g, vim.api

local buf_mapper = function(mode, key, result)
  api.nvim_buf_set_keymap(0, mode, key, '<cmd>lua ' .. result .. '<CR>',
                          {noremap = true, silent = true})
end

local tree_config = function()
  g.nvim_tree_side = 'left'
  g.nvim_tree_width = 30
  g.nvim_tree_disable_netrw = 0
  g.nvim_tree_hijack_netrw = 1
  g.nvim_tree_follow = 1
  g.nvim_tree_tab_open = 1
  g.nvim_tree_lint_lsp = 0
  g.nvim_tree_gitignore = 1
  g.nvim_tree_auto_open = 0
  g.nvim_tree_auto_close = 0
end

local tree_context_menu = function()
  vim.cmd('redraw! | echo | redraw!')
  local actions = {'create', 'rename', 'copy', 'cut', 'paste', 'remove'}
  local section = vim.fn.confirm('Action?',
                                 '&New file/directory\n&Rename\n&Copy\n&Move\n&Paste\n&Delete')
  vim.cmd('redraw!')
  require('nvim-tree').on_keypress(actions[section])
end

local tree_mapping = function()
  buf_mapper('n', 'm', 'require("lb.config.nvim-tree").tree_context_menu()')
  buf_mapper('n', 'r', 'require("nvim-tree").on_keypress("refresh")')
  buf_mapper('n', 's', 'require("nvim-tree").on_keypress("split")')
  buf_mapper('n', 'v', 'require("nvim-tree").on_keypress("vsplit")')
end

local tree_autocmd = function()
  vim.cmd [[augroup NvimTree]]
  vim.cmd [[ au!]]
  vim.cmd [[ autocmd FileType NvimTree :lua require('lb.config.nvim-tree').tree_mapping() ]]
  vim.cmd [[augroup END]]
end

local on_attach = function()
  tree_config()
  tree_autocmd()
end

return {
  tree_mapping = tree_mapping,
  tree_context_menu = tree_context_menu,
  on_attach = on_attach,
}
