-- =====================================================================
--
-- nvim-tree.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================

local tree_cb = require('nvim-tree.config').nvim_tree_callback
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

require('nvim-tree').setup {
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
    signcolumn = 'yes',
    mappings = {
      custom_only = true,
      list = {
        { key = 'm', cb = ':lua _G.lb_nvim_tree_context_menu()<CR>' },
        { key = { '<CR>', 'o' }, cb = tree_cb 'edit' },
        { key = 'v', cb = tree_cb 'vsplit' },
        { key = 's', cb = tree_cb 'split' },
        { key = 'R', cb = tree_cb 'refresh' },
        { key = 'y', cb = tree_cb 'copy_name' },
        { key = 'Y', cb = tree_cb 'copy_path' },
      },
    },
  },
}
