--=====================================================================
--
-- mason.lua -
--
-- Created by liubang on 2022/12/30 22:30
-- Last Modified: 2022/12/30 22:30
--
--=====================================================================

local M = { "williamboman/mason.nvim", cmd = "Mason" }

function M.config()
  require("mason").setup {
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
  }

  require("mason-lspconfig").setup {
    ensure_installed = {
      "clangd",
      "gopls",
      "sumneko_lua",
      "rust_analyzer",
      "bashls",
      "pyright",
    },
    automatic_installation = false,
  }
end

return M

-- vim: fdm=marker fdl=0
