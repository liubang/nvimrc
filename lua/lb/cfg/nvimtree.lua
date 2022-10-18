-- =====================================================================
--
-- nvim-tree.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2022/10/18 23:28
--
-- =====================================================================

if true then
  return
end

local nvim_tree = require 'nvim-tree'

nvim_tree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  auto_reload_on_write = true,
  respect_buf_cwd = false,
  renderer = {
    group_empty = true,
  },
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
    number = false,
    relativenumber = false,
    hide_root_folder = false,
    preserve_window_proportions = false,
    signcolumn = 'yes',
    mappings = {
      custom_only = true,
      list = {
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

local api = require 'nvim-tree.api'
api.events.subscribe(api.events.Event.FileCreated, function(data)
  vim.cmd('edit ' .. data.fname)
end)
