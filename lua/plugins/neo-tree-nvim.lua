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
  "nvim-neo-tree/neo-tree.nvim", -- {{{
  branch = "v3.x",
  cmd = "Neotree",
  enabled = false,
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  keys = { -- {{{
    {
      "<leader>ft",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  }, -- }}}
  init = function() -- {{{
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end, -- }}}
  opts = {
    close_if_last_window = true,
    enable_diagnostics = false,
    enable_git_status = true,
    use_default_mappings = false,
    event_handlers = { -- {{{
      {
        event = "file_added",
        handler = function(args)
          local stat = vim.loop.fs_stat(args)
          if stat and stat.type == "file" then -- ignoring when destination is dir
            vim.cmd.edit(args)
          end
        end,
      },
    }, -- }}}
    filesystem = { -- {{{
      bind_to_cwd = false,
      group_empty_dirs = true,
      follow_current_file = { enabled = true },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          "node_modules",
          ".git",
          "target",
          "vendor",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
    }, -- }}}
    window = { -- {{{{
      mappings = {
        ["<space>"] = "none",
        ["<cr>"] = "open_drop",
        ["o"] = "open_drop",
        ["s"] = "open_split",
        ["t"] = "open_tab_drop",
        ["v"] = "open_vsplit",
        ["a"] = { "add", config = { show_path = "relative" } },
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        ["R"] = "refresh",
        ["?"] = "show_help",
      },
    }, -- }}}
    default_component_configs = { -- {{{
      modified = {
        symbol = " ",
        highlight = "NeoTreeModified",
      },
      git_status = {
        symbols = {
          added = "",
          conflict = "",
          deleted = "",
          ignored = "◌",
          renamed = "➜",
          staged = "✓",
          unmerged = "",
          unstaged = "",
          untracked = "★",
        },
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "ﰊ",
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    }, -- }}}
  },
  -- }}}
}
