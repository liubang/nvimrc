-- =====================================================================
--
-- nvim-tree.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================

local nvim_tree = require 'nvim-tree'

_G.lb_nvim_tree_context_menu = function()
  vim.cmd 'redraw! | echo | redraw!'
  local actions = { 'create', 'rename', 'copy', 'cut', 'paste', 'remove' }
  local section = vim.fn.confirm(
    'Action?',
    '&New file/directory\n&Rename\n&Copy\n&Move\n&Paste\n&Delete'
  )
  vim.cmd 'redraw!'
  require('nvim-tree').on_keypress(actions[section])
end

vim.g.nvim_tree_respect_buf_cwd = 0
vim.g.nvim_tree_group_empty = 1

nvim_tree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  auto_close = false,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  auto_reload_on_write = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  diagnostics = {
    enable = false,
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 40,
    side = 'left',
    auto_resize = false,
    number = false,
    relativenumber = false,
    hide_root_folder = false,
    preserve_window_proportions = false,
    signcolumn = 'yes',
    mappings = {
      custom_only = true,
      list = {
        { key = 'm', cb = ':lua _G.lb_nvim_tree_context_menu()<CR>' },
        { key = { '<CR>', 'o' }, action = 'edit' },
        { key = 'a', action = 'create' },
        { key = 'v', action = 'vsplit' },
        { key = 's', action = 'split' },
        { key = 'r', action = 'rename' },
        { key = 'x', action = 'cut' },
        { key = 'c', action = 'copy' },
        { key = 'p', action = 'paste' },
        { key = 'R', action = 'refresh' },
        { key = 'y', action = 'copy_name' },
        { key = 'Y', action = 'copy_path' },
        { key = 'd', action = 'remove' },
        { key = '<C-k>', action = 'toggle_file_info' },
      },
    },
  },
}
