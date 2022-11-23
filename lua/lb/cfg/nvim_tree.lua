-- =====================================================================
--
-- nvim-tree.lua -
--
-- Created by liubang on 2020/12/11
-- Last Modified: 2022/11/01 23:20
--
-- =====================================================================

local nvim_tree = require 'nvim-tree'

nvim_tree.setup {
  disable_netrw = true,
  open_on_setup = false,
  open_on_tab = false,
  update_cwd = false,
  auto_reload_on_write = true,
  respect_buf_cwd = false,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_ft_on_setup = { 'alpha' },
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  diagnostics = {
    enable = false,
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = true,
    group_empty = true,
    icons = {
      glyphs = {
        default = '',
        symlink = '',
        folder = {
          default = '',
          empty = '',
          empty_open = '',
          open = '',
          symlink = '',
          symlink_open = '',
          arrow_open = '',
          arrow_closed = '',
        },
        git = { --{{{
          deleted = '',
          ignored = '◌',
          renamed = '➜',
          staged = '✓',
          unmerged = '',
          unstaged = '',
          untracked = '★',
        }, --}}}
      },
    },
  },
  view = {
    width = 35,
    side = 'left',
    adaptive_size = true,
    hide_root_folder = false,
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

vim.keymap.set('n', '<Leader>ft', nvim_tree.toggle, { silent = true, desc = 'toggle tree view' })

-- vim.api.nvim_create_autocmd('BufEnter', { --{{{
--   nested = true,
--   callback = function()
--     if vim.fn.winnr '$' == 1 and vim.fn.bufname() == 'NvimTree_' .. vim.fn.tabpagenr() then
--       vim.api.nvim_command ':silent q'
--     end
--   end,
-- }) --}}}

-- vim: fdm=marker fdl=0
