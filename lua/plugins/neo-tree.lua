--=====================================================================
--
-- neo-tree.lua -
--
-- Created by liubang on 2023/04/01 20:11
-- Last Modified: 2023/04/01 20:11
--
--=====================================================================

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = "Neotree",
  deactivate = function()
    vim.cmd [[Neotree close]]
  end,
  keys = {
    {
      "<leader>ft",
      function()
        require("neo-tree.command").execute { toggle = true, dir = vim.loop.cwd() }
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require "neo-tree"
      end
    end
  end,
  opts = {
    close_if_last_window = true,
    enable_diagnostics = false,
    enable_git_status = true,
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
      group_empty_dirs = true,
      filtered_items = {
        hide_by_name = {
          "node_modules",
          ".git",
          "target",
          "vendor",
        },
      },
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["<cr>"] = "open_drop",
        ["o"] = "open_drop",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["a"] = {
          "add",
          config = {
            show_path = "none", -- "none", "relative", "absolute"
          },
        },
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
    },
    default_component_configs = {
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
    },
  },
}
