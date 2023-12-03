--=====================================================================
--
-- nvim-navic.lua -
--
-- Created by liubang on 2023/11/26 16:04
-- Last Modified: 2023/11/26 16:04
--
--=====================================================================

return {
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
    -- stylua: ignore
    return {
      icons                 = require('lb.config').kinds,
      separator             = " > ",
      depth_limit           = 3,
      highlight             = true,
      depth_limit_indicator = "..",
      safe_output           = true,
    }
  end,
  -- }}}
}
