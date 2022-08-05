--=====================================================================
--
-- rust.lua -
--
-- Created by liubang on 2022/08/06 00:24
-- Last Modified: 2022/08/06 00:24
--
--=====================================================================
local c = require 'lb.lsp.customs'

local setup = function()
  require('rust-tools').setup {
    tools = {
      autoSetHints = true,
      hover_with_actions = true,
      inlay_hints = {
        show_parameter_hints = false,
        parameter_hints_prefix = '',
        other_hints_prefix = '',
      },
    },

    -- all the opts to send to nvim-lspconfig
    server = c.default {
      settings = {
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ['rust-analyzer'] = {
          -- enable clippy on save
          checkOnSave = {
            command = 'clippy',
          },
        },
      },
    },
  }
end

return {
  setup = setup,
}
