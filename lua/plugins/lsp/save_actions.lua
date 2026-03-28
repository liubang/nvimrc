-- Copyright (c) 2026 The Authors. All rights reserved.
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

local M = {}

local save_actions = {
  go = function(bufnr)
    local gopls = vim.lsp.get_clients({ bufnr = bufnr, name = "gopls" })[1]
    require("venux.utils.util").codeaction(gopls, "", "source.organizeImports", 1000)
    require("plugins.lsp.format").format(bufnr)
  end,
}

function M.setup()
  local group = vim.api.nvim_create_augroup("LSP_SAVE_ACTIONS", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = vim.tbl_keys(save_actions),
    callback = function(event)
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        buffer = event.buf,
        callback = function()
          save_actions[vim.bo[event.buf].filetype](event.buf)
        end,
      })
    end,
  })
end

return M
