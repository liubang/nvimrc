--=====================================================================
--
-- rust.lua -
--
-- Created by liubang on 2022/08/06 00:24
-- Last Modified: 2022/08/06 00:24
--
--=====================================================================
require("packer").loader "rust-tools.nvim"

local c = require "lb.cfg.lsp.customs"
local M = {}

M.setup = function()
  require("rust-tools").setup {
    tools = {
      -- how to execute terminal commands
      -- options right now: termopen / quickfix
      executor = require("rust-tools/executors").termopen,

      -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
      reload_workspace_from_cargo_toml = true,

      inlay_hints = {
        auto = true,
        only_current_line = true,
        show_parameter_hints = false,
      },
    },

    -- all the opts to send to nvim-lspconfig
    server = c.default {
      -- standalone file support
      -- setting it to false may improve startup time
      standalone = true,

      settings = {
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ["rust-analyzer"] = {
          -- enable clippy on save
          -- checkOnSave = {
          --   command = 'clippy',
          -- },
        },
      },
    },
  }
end

return M
