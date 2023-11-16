--=====================================================================
--
-- ui.lua -
--
-- Created by liubang on 2023/05/12 14:02
-- Last Modified: 2023/05/12 14:02
--
--=====================================================================

return {
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim" },
  -- theme
  {
    "sainnhe/gruvbox-material", -- {{{
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.o.guifont = "Operator Mono Lig:h18,Hack Nerd Font:h18"

      -- neowide {{{
      vim.g.neovide_refresh_rate = 60
      vim.g.neovide_cursor_vfx_mode = "railgun"
      vim.g.neovide_no_idle = true
      vim.g.neovide_cursor_animation_length = 0.03
      vim.g.neovide_cursor_trail_length = 0.05
      vim.g.neovide_cursor_antialiasing = true
      vim.g.neovide_cursor_vfx_opacity = 200.0
      vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
      vim.g.neovide_cursor_vfx_particle_speed = 20.0
      vim.g.neovide_cursor_vfx_particle_density = 5.0
      -- }}}

      -- theme {{{
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_filetype_hi_groups = 0
      vim.g.gruvbox_plugin_hi_groups = 0
      vim.g.gruvbox_transp_bg = 1
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_disable_italic_comment = 0
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_disable_italic_comment = 1
      -- }}}

      vim.cmd.colorscheme("gruvbox-material")
      vim.o.foldtext = 'v:lua.require("lb.utils.fold").foldtext()'
    end,
    -- }}}
  },
  -- dashboard
  {
    "goolord/alpha-nvim", -- {{{
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        [[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓]],
        [[ ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒]],
        [[▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░]],
        [[▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ]],
        [[▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒]],
        [[░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░]],
        [[░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░]],
        [[   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ]],
        [[         ░    ░  ░    ░ ░        ░   ░         ░   ]],
        [[                                ░                  ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("SPC ff", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("SPC bb", " " .. " List buffers", ":Telescope buffers <CR>"),
        dashboard.button("SPC rf", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("SPC ag", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }

      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end

      dashboard.section.header.opts.hl = "Keyword"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 6
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "󰏗  Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
    -- }}}
  },
  -- outline
  {
    "stevearc/aerial.nvim", -- {{{
    branch = "master",
    cmd = "AerialToggle",
    opts = {
      backends = { "lsp", "markdown" },
      layout = {
        default_direction = "prefer_right",
        placement = "edge",
      },
      attach_mode = "global", -- 'window' | 'global'
      nerd_font = "auto",
      show_guides = true,
      keymaps = {
        ["<CR>"] = false,
        ["o"] = "actions.jump",
        ["<C-j>"] = "actions.down_and_scroll",
        ["<C-k>"] = "actions.up_and_scroll",
        ["O"] = "actions.tree_toggle",
      },
    },
    keys = {
      { "<Leader>tl", "<CMD>AerialToggle<CR>", mode = { "n" }, desc = "Open or close the aerial window" },
    },
    -- }}}
  },
  -- file tree
  {
    "nvim-neo-tree/neo-tree.nvim", -- {{{
    branch = "v3.x",
    cmd = "Neotree",
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
  },
  -- undotree
  {
    "mbbill/undotree", -- {{{
    branch = "search",
    cmd = { "UndotreeShow", "UndotreeToggle" },
    config = function()
      vim.g.undotree_CustomUndotreeCmd = "vertical 40 new"
      vim.g.undotree_CustomDiffpanelCmd = "botright 15 new"
    end,
    keys = {
      { "<Leader>u", "<CMD>UndotreeToggle<CR>", mode = { "n" }, desc = "Toggle undotree" },
    },
    -- }}}
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim", -- {{{
    event = "VeryLazy",
    opts = {
      options = { -- {{{
        -- themable = true,
        numbers = "ordinal",
        indicator = { style = "underline" },
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        middle_mouse_command = nil,
        buffer_close_icon = "",
        modified_icon = "󰣕 ",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        diagnostics = false,
        diagnostics_update_in_insert = false,
        sort_by = "insert_at_end",
      }, -- }}}
    },
    config = function(_, opts)
      local bufferline = require("bufferline")
      opts.options.style_preset = {
        bufferline.style_preset.no_italic,
        bufferline.style_preset.no_bold,
      }
      bufferline.setup(opts)
    end,
    keys = {
      { "<Leader>1", "<CMD>BufferLineGoToBuffer 1<CR>", mode = { "n" }, desc = "Goto the 1th visible buffer" },
      { "<Leader>2", "<CMD>BufferLineGoToBuffer 2<CR>", mode = { "n" }, desc = "Goto the 2th visible buffer" },
      { "<Leader>3", "<CMD>BufferLineGoToBuffer 3<CR>", mode = { "n" }, desc = "Goto the 3th visible buffer" },
      { "<Leader>4", "<CMD>BufferLineGoToBuffer 4<CR>", mode = { "n" }, desc = "Goto the 4th visible buffer" },
      { "<Leader>5", "<CMD>BufferLineGoToBuffer 5<CR>", mode = { "n" }, desc = "Goto the 5th visible buffer" },
      { "<Leader>6", "<CMD>BufferLineGoToBuffer 6<CR>", mode = { "n" }, desc = "Goto the 6th visible buffer" },
      { "<Leader>7", "<CMD>BufferLineGoToBuffer 7<CR>", mode = { "n" }, desc = "Goto the 7th visible buffer" },
      { "<Leader>8", "<CMD>BufferLineGoToBuffer 8<CR>", mode = { "n" }, desc = "Goto the 8th visible buffer" },
      { "<Leader>9", "<CMD>BufferLineGoToBuffer 9<CR>", mode = { "n" }, desc = "Goto the 9th visible buffer" },
    },
    -- }}}
  },
  -- statusline
  {
    "nvim-lualine/lualine.nvim", -- {{{
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          icons_enabled = true,
          component_separators = "",
          section_separators = "",
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { require("lb.utils.util").mode_format },
          lualine_b = {
            { "branch", icon = "\u{e725}" },
            { "diff" },
            { "diagnostics", colored = true },
          },
          lualine_c = {
            {
              "filename",
              path = 1,
              file_status = true,
              shorting_target = 40,
              symbols = {
                modified = " \u{f040}",
                readonly = " \u{f023}",
                unnamed = "[No Name]",
              },
              cond = function()
                local f = vim.fn.expand("%:p")
                return f:len() <= 6 or f:sub(0, 6) ~= "jdt://"
              end,
            },
            {
              require("lb.utils.util").file_size_format,
              cond = function()
                local ft = vim.api.nvim_buf_get_option(0, "filetype")
                if ft == "alpha" or ft == "NvimTree" or ft == "aerial" then
                  return false
                end
                return true
              end,
            },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return require("nvim-navic").is_available()
              end,
            },
          },
          lualine_x = {
            require("lb.utils.util").lineinfo,
            {
              require("lb.utils.util").lsp_clients_format,
              cond = function()
                local ft = vim.api.nvim_buf_get_option(0, "filetype")
                if ft == "alpha" or ft == "NvimTree" or ft == "aerial" then
                  return false
                end
                return next(vim.lsp.get_active_clients({ bufnr = 0 })) ~= nil
              end,
            },
          },
          lualine_y = {
            { "filetype", icon_only = true, colored = true },
            { "encoding" },
          },
          lualine_z = {
            {
              "fileformat",
              icons_enabled = true,
              symbols = {
                unix = " UNIX",
                dos = " WIN",
                mac = " OSX",
              },
            },
          },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { "nvim-tree" },
      }
    end,
    -- }}}
  },
  {
    "j-hui/fidget.nvim", -- {{{
    event = { "LspAttach" },
    opts = {
      progress = {
        ignore = { "null-ls" },
      },
    },
    -- }}}
  },
  -- wilder ui
  {
    "gelguy/wilder.nvim", -- {{{
    dependencies = { "romgrk/fzy-lua-native" },
    event = "CmdlineEnter",
    config = function()
      local wilder = require("wilder")

      wilder.setup({ modes = { ":", "/", "?" } })
      -- Disable Python remote plugin
      wilder.set_option("use_python_remote_plugin", 0)

      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(),
          }),
          wilder.vim_search_pipeline()
        ),
      })

      wilder.set_option(
        "renderer",
        wilder.renderer_mux({
          [":"] = wilder.wildmenu_renderer({
            -- max_width = 14,
            -- max_height = 17,
            highlighter = wilder.lua_fzy_highlighter(),
            -- left = {
            --   " ",
            --   wilder.popupmenu_devicons(),
            -- },
            -- right = {
            --   " ",
            --   wilder.popupmenu_scrollbar(),
            -- },
            highlights = {
              accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#ea6962" } }),
            },
          }),
          ["/"] = wilder.wildmenu_renderer({
            highlighter = wilder.lua_fzy_highlighter(),
            highlights = {
              accent = wilder.make_hl("WilderAccent", "Pmenu", { { a = 1 }, { a = 1 }, { foreground = "#ea6962" } }),
            },
          }),
        })
      )
    end,
    -- }}}
  },
  {
    "SmiteshP/nvim-navic", -- {{{
    init = function()
      vim.g.navic_silence = true
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.documentSymbolProvider ~= nil then
            require("nvim-navic").attach(client, buffer)
          end
        end,
      })
    end,
    opts = function()
      return {
        -- stylua: ignore
        icons = require('lb.config').kinds,
        separator = " > ",
        depth_limit = 3,
        highlight = true,
        depth_limit_indicator = "..",
        safe_output = true,
      }
    end,
    -- }}}
  },
}

-- vim: fdm=marker fdl=0
