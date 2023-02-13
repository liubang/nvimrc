--=====================================================================
--
-- mason.lua -
--
-- Created by liubang on 2022/12/30 22:30
-- Last Modified: 2022/12/30 22:30
--
--=====================================================================

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "single",
        icons = {
          package_uninstalled = "",
          package_installed = "",
          package_pending = " ",
        },
        keymaps = {
          toggle_package_expand = "<CR>",
          install_package = "i",
          update_package = "u",
          check_package_version = "c",
          update_all_packages = "U",
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "<C-f>",
        },
      },
      max_concurrent_installers = 4,
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "gopls",
        "lua_ls",
        "rust_analyzer",
        "bashls",
        "pyright",
      },
      automatic_installation = false,
    },
  },
}

-- vim: fdm=marker fdl=0
