-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

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
