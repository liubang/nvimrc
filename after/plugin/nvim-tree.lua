-- =====================================================================
--
-- nvim-tree.lua - 
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2020/12/11 00:23
--
-- =====================================================================
local g, api = vim.g, vim.api
local tree_cb = require('nvim-tree.config').nvim_tree_callback

_G.lb_nvim_tree_context_menu = function()
  vim.cmd('redraw! | echo | redraw!')
  local actions = {'create', 'rename', 'copy', 'cut', 'paste', 'remove'}
  local section = vim.fn.confirm('Action?',
                                 '&New file/directory\n&Rename\n&Copy\n&Move\n&Paste\n&Delete')
  vim.cmd('redraw!')
  require('nvim-tree.config').nvim_tree_callback(actions[section])
end

require('nvim-tree').setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {'startify', 'dashboard'},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  lsp_diagnostics     = false,
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  view = {
    width = 35,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = true,
      list = {
        { key = "m",                            cb = ":lua _G.lb_nvim_tree_context_menu()<CR>" },
        { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
        { key = "v",                            cb = tree_cb("vsplit") },
        { key = "s",                            cb = tree_cb("split") },
      }
    }
  }
}
