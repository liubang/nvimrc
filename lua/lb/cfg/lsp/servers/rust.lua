--=====================================================================
--
-- rust.lua -
--
-- Created by liubang on 2022/08/06 00:24
-- Last Modified: 2022/08/06 00:24
--
--=====================================================================
local c = require 'lb.cfg.lsp.customs'
local M = {}

vim.cmd.packadd 'rust-tools.nvim'

M.setup = function()
  require('rust-tools').setup {
    tools = {
      inlay_hints = {
        auto = true,
        only_current_line = true,
        show_parameter_hints = false,
      },
    },

    -- all the opts to send to nvim-lspconfig
    server = c.default {
      standalone = false,
      settings = {
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ['rust-analyzer'] = {
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
