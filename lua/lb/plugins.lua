-- =====================================================================
--
-- plugins.lua -
--
-- Created by liubang on 2021/04/19 11:00
-- Last Modified: 2022/12/07 19:49
--
-- =====================================================================

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd.packadd "packer.nvim"

local config = { --{{{
  auto_clean = true,
  compile_on_sync = true,
  ensure_dependencies = true,
  auto_reload_compiled = true,
  profile = {
    enable = false,
    threshold = 1,
  },
  display = {
    title = " packer.nvim",
    non_interactive = false,
    header_lines = 2,
    working_sym = " ",
    moved_sym = " ",
    error_sym = "",
    done_sym = "",
    removed_sym = "",
    show_all_info = true,
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
  },
  git = {
    depth = 1,
    clone_timeout = 300,
  },
} --}}}

require("packer").startup {
  function(use)
    -- Libraries {{{
    -- have packer manage itself
    use { "wbthomason/packer.nvim", event = { "VimEnter" } }
    use { "nvim-lua/plenary.nvim" }
    use { "lewis6991/impatient.nvim" }
    -- }}}

    -- appearance {{{
    use { "nvim-tree/nvim-web-devicons", opt = true }
    use {
      "sainnhe/gruvbox-material",
      config = function()
        require "lb.cfg.theme"
      end,
    }
    use {
      "goolord/alpha-nvim",
      config = function()
        require "lb.cfg.alpha"
      end,
      event = { "BufWinEnter" },
    }

    use {
      "rcarriga/nvim-notify",
      config = function()
        require "lb.cfg.notify"
      end,
      event = { "User LoadTicker2" },
    }
    use {
      "akinsho/bufferline.nvim",
      tag = "v3.*",
      config = function()
        require "lb.cfg.bufferline"
      end,
      event = { "UIEnter" },
    }
    use {
      "nvim-lualine/lualine.nvim",
      requires = {
        "nvim-tree/nvim-web-devicons",
        "SmiteshP/nvim-navic",
      },
      config = function()
        require "lb.cfg.lualine"
      end,
      event = { "UIEnter" },
    }
    use {
      "nvim-tree/nvim-tree.lua",
      requires = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require "lb.cfg.nvim-tree"
      end,
      -- keys = { '<Leader>ft' },
      cmd = { "NvimTreeOpen", "NvimTreeToggle", "NvimTreeFindFile" },
    }
    -- }}}

    -- tools {{{
    use {
      "rainbowhxch/accelerated-jk.nvim",
      config = function()
        require "lb.cfg.accelerated-jk"
      end,
      keys = { "<Plug>(accelerated_jk_gj)", "<Plug>(accelerated_jk_gk)" },
    }
    use {
      "ibhagwan/smartyank.nvim",
      config = function()
        require "lb.cfg.smartyank"
      end,
      event = { "User LoadTicker4" },
    }
    use {
      "mrjones2014/smart-splits.nvim",
      config = function()
        require "lb.cfg.smartsplit"
      end,
      event = { "User LoadTicker4" },
    }
    use {
      "jbyuki/venn.nvim",
      config = function()
        require "lb.cfg.venn"
      end,
      keys = { "<Leader>v" },
    }
    -- https://github.com/ArthurSonzogni/Diagon
    use {
      "willchao612/vim-diagon",
      cmd = { "Diagon" },
    }
    use {
      "phaazon/hop.nvim",
      branch = "v2",
      config = function()
        require("hop").setup {}
      end,
      event = { "User LoadTicker3" },
    }
    use {
      "voldikss/vim-floaterm",
      config = function()
        require "lb.cfg.floaterm"
      end,
      cmd = { "FloatermNew", "FloatermToggle", "FloatermPrev", "FloatermNext" },
    }
    use {
      "skywind3000/asynctasks.vim",
      requires = {
        { "skywind3000/asyncrun.vim", opt = true },
        { "skywind3000/asyncrun.extra", opt = true },
        { "voldikss/vim-floaterm", opt = true },
      },
      config = function()
        require "lb.cfg.asynctasks"
      end,
      cmd = { "AsyncTask", "AsyncRun" },
    }
    use {
      "lewis6991/gitsigns.nvim",
      requires = "plenary.nvim",
      config = function()
        require "lb.cfg.git"
      end,
      event = { "User LoadTicker3" },
    }
    use {
      "echasnovski/mini.nvim",
      config = function()
        require "lb.cfg.mini-nvim"
      end,
      event = { "User LoadTicker3" },
    }
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
    use { "arthurxavierx/vim-caser", keys = { "gs" } }
    use {
      "nvim-telescope/telescope.nvim",
      -- branch = "0.1.x",
      requires = {
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = [[
                  cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release \
                     && cmake --build build --config Release \
                     && cmake --install build --prefix build
                ]],
          after = { "telescope.nvim" },
        },
        {
          "nvim-telescope/telescope-ui-select.nvim",
          after = { "telescope.nvim" },
        },
      },
      module = "telescope", -- 不能删
      config = function()
        require "lb.cfg.telescope"
      end,
      cmd = "Telescope",
      event = { "User LoadTicker3" }, -- for auto load telescope-ui-select
    }

    use {
      "stevearc/aerial.nvim",
      config = function()
        require "lb.cfg.aerial"
      end,
      cmd = { "AerialToggle" },
    }

    use {
      "dstein64/vim-startuptime",
      cmd = { "StartupTime" },
    }
    -- }}}

    -- treesitter {{{
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        {
          "nvim-treesitter/nvim-treesitter-textobjects",
          after = "nvim-treesitter",
          config = function()
            require "lb.cfg.treesitter"
          end,
        },
        { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
        {
          "nvim-treesitter/playground",
          run = ":TSInstall query",
          cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
        },
      },
      run = ":TSUpdate",
      event = { "User LoadTicker1", "BufReadPost", "BufNewFile" },
    }

    use {
      "numToStr/Comment.nvim",
      after = { "nvim-ts-context-commentstring", "nvim-treesitter" },
      config = function()
        require "lb.cfg.comment"
      end,
    }
    -- }}}

    -- lsp {{{
    use { "folke/neodev.nvim", opt = true }
    use { "simrat39/rust-tools.nvim", opt = true }
    use { "b0o/schemastore.nvim", opt = true }
    use { "jose-elias-alvarez/null-ls.nvim", opt = true }
    use { "williamboman/mason.nvim", opt = true }
    use { "williamboman/mason-lspconfig.nvim", opt = true }
    use {
      "neovim/nvim-lspconfig",
      config = function()
        -- It's important that you set up the plugins in the following order:
        -- 1. mason.nvim
        -- 2. mason-lspconfig.nvim
        -- Setup servers via lspconfig
        require "lb.cfg.mason"
        require "lb.cfg.lsp"
      end,
      event = { "User LoadTicker2", "BufReadPost", "BufNewFile" },
    }
    use {
      "j-hui/fidget.nvim",
      config = function()
        require "lb.cfg.fidget"
      end,
      after = { "nvim-lspconfig" },
    }
    use {
      "SmiteshP/nvim-navic",
      config = function()
        require "lb.cfg.nvim-navic"
      end,
      event = { "LspAttach" },
    }
    -- }}}

    -- completion {{{
    use {
      "onsails/lspkind.nvim",
      opt = true,
      config = function()
        require "lb.cfg.lspkind"
      end,
    }

    use {
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-calc", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
        { "kdheepak/cmp-latex-symbols", after = "nvim-cmp" },
      },
      config = function()
        require "lb.cfg.cmp"
      end,
      event = { "User LoadTicker1" },
    }

    use {
      "L3MON4D3/LuaSnip",
      after = { "nvim-cmp", "Comment.nvim" },
      config = function()
        require "lb.cfg.luasnip"
      end,
      event = { "User LoadTicker2" },
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require "lb.cfg.autopairs"
      end,
      after = { "nvim-cmp" },
      wants = { "nvim-cmp" },
    }

    use {
      "saecki/crates.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require "lb.cfg.crates-nvim"
      end,
      event = { "BufRead Cargo.toml" },
      after = { "nvim-cmp" },
      wants = { "nvim-cmp" },
    }

    use {
      "gelguy/wilder.nvim",
      requires = { "romgrk/fzy-lua-native", opt = true, run = "make" },
      config = function()
        require "lb.cfg.wilder"
      end,
      event = { "CmdlineEnter" },
    }
    -- }}}

    -- ft {{{
    local colorizer_ft = {
      "css",
      "scss",
      "sass",
      "html",
      "lua",
      "vim",
      "markdown",
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
    }
    use {
      "NvChad/nvim-colorizer.lua",
      ft = colorizer_ft,
      config = function()
        require("colorizer").setup {
          filetypes = colorizer_ft,
          user_default_options = {
            mode = "virtualtext",
            virtualtext = "■",
          },
        }
      end,
    }

    use {
      "iamcco/markdown-preview.nvim",
      ft = { "markdown" },
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      setup = function()
        vim.g.mkdp_filetypes = { "markdown" }
      end,
    }
    -- }}}

    if is_bootstrap then
      require("packer").sync()
    end
  end,
  config = config,
}

-- print messages when bootstrap {{{
if is_bootstrap then
  print "=================================="
  print "    Plugins are being installed"
  print "    Wait until Packer completes,"
  print "       then restart nvim"
  print "=================================="
  return
end

-- vim: fdm=marker fdl=0
