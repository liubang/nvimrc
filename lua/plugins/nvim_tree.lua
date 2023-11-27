--=====================================================================
--
-- nvim_tree.lua -
--
-- Created by liubang on 2023/11/26 18:22
-- Last Modified: 2023/11/26 18:22
--
--=====================================================================

return {
  "nvim-tree/nvim-tree.lua",
  cmd = {
    "NvimTreeToggle",
    "NvimTreeOpen",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
    "NvimTreeRefresh",
  },
  keys = { { "<leader>ft", "<cmd>NvimTreeToggle<CR>", desc = "Explorer NvimTree (cwd)" } },
  opts = {
    auto_reload_on_write = false,
    create_in_closed_folder = false,
    disable_netrw = false,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = true,
    open_on_tab = false,
    respect_buf_cwd = false,
    sort_by = "name",
    sync_root_with_cwd = true,
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 40,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      float = {
        enable = false,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
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
      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
      vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
    end,
    renderer = {
      add_trailing = false,
      group_empty = true,
      highlight_git = true,
      full_name = false,
      highlight_opened_files = "none",
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt" },
      symlink_destination = true,
      indent_markers = {
        enable = true,
        icons = {
          corner = "└ ",
          edge = "│ ",
          item = "│ ",
          none = "  ",
        },
      },
      root_folder_label = ":.:s?.*?/..?",
      icons = {
        webdev_colors = true,
        git_placement = "after",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
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
            open = "",
            empty = "ﰊ",
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
