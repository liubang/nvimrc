-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

return {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeOpen",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
    "NvimTreeRefresh",
  },
  enabled = false,
  keys = { { "<leader>ft", "<cmd>NvimTreeToggle<CR>", desc = "Explorer NvimTree (cwd)" } },
  opts = {
    auto_reload_on_write = false,
    create_in_closed_folder = false,
    disable_netrw = false,
    hijack_cursor = false,
    hijack_netrw = true,
    open_on_tab = false,
    respect_buf_cwd = false,
    sort_by = "name",
    sync_root_with_cwd = false,
    prefer_startup_root = true,
    hijack_unnamed_buffer_when_opening = false,
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 40,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      local git_add = function()
        local node = api.tree.get_node_under_cursor()
        local gs = node.git_status.file
        -- If the current node is a directory get children status
        if gs == nil then
          gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
            or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
        end
        -- If the file is untracked, unstaged or partially staged, we stage it
        if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
          vim.cmd("silent !git add " .. node.absolute_path)
        -- If the file is staged, we unstage
        elseif gs == "M " or gs == "A " then
          vim.cmd("silent !git restore --staged " .. node.absolute_path)
        end
        api.tree.reload()
      end

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
      vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
      vim.keymap.set("n", "ga", git_add, opts("Git Add"))

      api.events.subscribe(api.events.Event.FileCreated, function(file)
        vim.cmd("edit " .. file.fname)
      end)
    end,
    renderer = {
      root_folder_label = false,
      add_trailing = false,
      group_empty = true,
      highlight_git = true,
      full_name = false,
      highlight_opened_files = "none",
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
      symlink_destination = true,
      indent_markers = {
        enable = false,
      },
      icons = {
        webdev_colors = true,
        git_placement = "after",
        show = {
          git = true,
          file = true,
          folder = true,
          folder_arrow = true,
        },
        padding = " ",
        symlink_arrow = " 󰁔 ",
        glyphs = {
          git = {
            deleted = "",
            ignored = "◌",
            renamed = "➜",
            staged = "✓",
            unmerged = "",
            unstaged = "",
            untracked = "★",
          },
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink_open = "",
            arrow_open = "",
            arrow_closed = "",
          },
        },
      },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = {},
    },
    filters = {
      dotfiles = false,
      custom = { ".DS_Store" },
      exclude = {},
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
      },
      open_file = {
        quit_on_open = false,
        resize_window = false,
        window_picker = {
          enable = true,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "terminal", "help" },
          },
        },
      },
      remove_file = { close_window = true },
    },
    diagnostics = { enable = false },
    filesystem_watchers = { enable = false },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      timeout = 400,
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    log = { enable = false },
  },
}
