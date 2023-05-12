--=====================================================================
--
-- utils.lua -
--
-- Created by liubang on 2023/05/12 14:23
-- Last Modified: 2023/05/12 14:23
--
--=====================================================================

return {
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  {
    "skywind3000/asynctasks.vim", -- {{{
    dependencies = {
      { "skywind3000/asyncrun.vim" },
      { "skywind3000/asyncrun.extra" },
    },
    cmd = { "AsyncTask", "AsyncRun" },
    config = function() -- {{{
      vim.g.asyncrun_bell = 1
      vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "build.xml" }
      vim.g.asynctasks_term_pos = "floaterm"
    end, -- }}}
    keys = {
      { "<C-b>", "<CMD>AsyncTask file-build<CR>", mode = { "n" }, desc = "Build current file" },
      { "<C-r>", "<CMD>AsyncTask file-run<CR>", mode = { "n" }, desc = "Run current file" },
      { "<C-x>", "<CMD>AsyncTask file-build-run<CR>", mode = { "n" }, desc = "Build and run current file" },
    },
    -- }}}
  },

  -- https://github.com/ArthurSonzogni/Diagon
  { "willchao612/vim-diagon", cmd = { "Diagon" } },

  {
    -- MixedCase/PascalCase:   gsm/gsp
    -- camelCase:              gsc
    -- snake_case:             gs_
    -- UPPER_CASE:             gsu/gsU
    -- Title Case:             gst
    -- Sentence case:          gss
    -- space case:             gs<space>
    -- dash-case/kebab-case:   gs-/gsk
    -- Title-Dash/Title-Kebab: gsK
    -- dot.case:               gs.
    "arthurxavierx/vim-caser",
    keys = { { "gs", mode = { "n", "x" } } },
  },

  {
    "voldikss/vim-floaterm", -- {{{
    config = function()
      vim.g.floaterm_wintype = "float"
      vim.g.floaterm_position = "bottom"
      vim.g.floaterm_autoinsert = true
      vim.g.floaterm_width = 0.999
      vim.g.floaterm_height = 0.7
      vim.g.floaterm_title = "─────  Floaterm [$1|$2] "
    end,
    cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
    keys = {
      { "<C-t>", "<CMD>FloatermToggle<CR>", desc = "Toggle floaterm" },
      {
        "<C-n>",
        vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNew<CR>", true, true, true),
        mode = { "t" },
        desc = "Create a new floaterm window",
      },
      {
        "<C-k>",
        vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermPrev<CR>", true, true, true),
        mode = { "t" },
        desc = "Goto previous floaterm window",
      },
      {
        "<C-j>",
        vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermNext<CR>", true, true, true),
        mode = { "t" },
        desc = "Goto next floaterm window",
      },
      {
        "<C-t>",
        vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermToggle<CR>", true, true, true),
        mode = { "t" },
        desc = "Toggle floaterm",
      },
      {
        "<C-d>",
        vim.api.nvim_replace_termcodes("<C-\\><C-N>:FloatermKill<CR>", true, true, true),
        mode = { "t" },
        desc = "Kill floaterm",
      },
    },
    -- }}}
  },

  {
    "gbprod/yanky.nvim", -- {{{
    dependencies = { "kkharji/sqlite.lua" },
    keys = {
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
    },
    opts = {
      system_clipboard = {
        sync_with_ring = true,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 300,
      },
      preserve_cursor_position = {
        enabled = true,
      },
      ring = { storage = jit.os:find "Windows" and "shada" or "sqlite" },
    },
    -- }}}
  },

  {
    "tpope/vim-fugitive", -- {{{
    dependencies = { "tpope/vim-git" },
    cmd = { "Git", "Gdiffsplit", "Gread" },
    -- }}}
  },

  {
    "lewis6991/gitsigns.nvim", -- {{{
    event = { "BufReadPre", "BufNewFile" },
    cmd = "Gitsigns",
    opts = {
      signs = {
        add = { text = "▌", show_count = true },
        change = { text = "▌", show_count = true },
        delete = { text = "▐", show_count = true },
        topdelete = { text = "▛", show_count = true },
        changedelete = { text = "▚", show_count = true },
      },
      sign_priority = 10,
      count_chars = {
        [1] = "",
        [2] = "₂",
        [3] = "₃",
        [4] = "₄",
        [5] = "₅",
        [6] = "₆",
        [7] = "₇",
        [8] = "₈",
        [9] = "₉",
        ["+"] = "₊",
      },
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = { enable = false },
    },
    keys = {
      {
        "<Leader>hb",
        function()
          require("gitsigns").blame_line { full = true }
        end,
        mode = { "n" },
        desc = "Show the line git blame in a floating window",
      },
      {
        "<Leader>hd",
        function()
          require("gitsigns").diffthis()
        end,
        mode = { "n" },
        desc = "Perform a `vimdiff` on the given file",
      },
      {
        "<Leader>hr",
        function()
          require("gitsigns").reset_hunk()
        end,
        mode = { "n" },
        desc = "Reset the lines of the hunk at the cursor position",
      },
      {
        "<Leader>hs",
        function()
          require("gitsigns").stage_hunk()
        end,
        mode = { "n" },
        desc = "Stage the hunk at the cursor position",
      },
    },
    -- }}}
  },

  {
    "nvim-pack/nvim-spectre", -- {{{
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
    -- }}}
  },

  {
    "mrjones2014/smart-splits.nvim", -- {{{
    opts = {
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "NvimTree",
        "Outline",
        "qf",
        "prompt",
      },
      ignored_buftypes = { "NvimTree", "Outline" },
      resize_mode = { quit_key = "<ESC>", silent = true },
    },
    -- stylua: ignore
    keys = {
      { "<C-S-Up>", function() require("smart-splits").resize_up() end, mode = { "n" } },
      { "<C-S-Down>", function() require("smart-splits").resize_down() end, mode = { "n" } },
      { "<C-S-Left>", function() require("smart-splits").resize_left() end, mode = { "n" } },
      { "<C-S-Right>", function() require("smart-splits").resize_right() end, mode = { "n" } },
    },
    -- }}}
  },

  {
    "NvChad/nvim-colorizer.lua", -- {{{
    ft = { "css", "scss", "sass", "html", "lua", "markdown", "javascript", "typescript" },
    opts = {
      filetypes = { "css", "scss", "sass", "html", "lua", "markdown", "javascript", "typescript" },
      r_default_options = {
        mode = "virtualtext",
        virtualtext = "■",
      },
    },
    -- }}}
  },

  {
    "echasnovski/mini.surround", -- {{{
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      n_lines = 40,
      highlight_duration = 1000,
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
    end,
    -- }}}
  },

  {
    "echasnovski/mini.align", -- {{{
    keys = {
      { "ga", mode = { "n", "x" } },
      { "gA", mode = { "n", "x" } },
    },
    opts = {
      mappings = {
        start = "ga",
        start_with_preview = "gA",
      },
      -- Default options controlling alignment process
      options = {
        split_pattern = "",
        justify_side = "left",
        merge_delimiter = "",
      },
      -- Default steps performing alignment (if `nil`, default is used)
      steps = {
        pre_split = {},
        split = nil,
        pre_justify = {},
        justify = nil,
        pre_merge = {},
        merge = nil,
      },
    },
    config = function(_, opts)
      require("mini.align").setup(opts)
    end,
    -- }}}
  },

  {
    "echasnovski/mini.bufremove", -- {{{
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
    -- }}}
  },

  {
    "echasnovski/mini.ai", -- {{{
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
        end,
      },
    },
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
        mappings = {
          -- Main textobject prefixes
          around = "a",
          inside = "i",
          -- Next/last variants
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",
          -- Move cursor to corresponding edge of `a` textobject
          goto_left = "g[",
          goto_right = "g]",
        },
        n_lines = 500,
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
    -- }}}
  },
}

-- vim: fdm=marker fdl=0
