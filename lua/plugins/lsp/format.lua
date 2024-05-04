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

local M = {}

local autoformats = {
  rust = true,
  lua = true,
}

function M.format()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  local have_nls = #require("null-ls.sources").get_available(filetype, "NULL_LS_FORMATTING") > 0
  local filter = function(client)
    if have_nls then
      return client.name == "null-ls"
    end
    return client.name ~= "null-ls"
  end
  vim.lsp.buf.format({ async = false, bufnr = bufnr, filter = filter })
end

function M.on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  if client.supports_method("textDocument/formatting") then
    vim.keymap.set("n", "<Leader>fm", function()
      M.format()
    end, opts)

    -- auto format
    if autoformats[vim.bo[bufnr].filetype] then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
        buffer = bufnr,
        callback = function()
          M.format()
        end,
      })
    end
  end

  if client.supports_method("textDocument/rangeFormatting") then
    vim.keymap.set("v", "<Leader>fm", function()
      M.format()
    end, opts)
  end
end

return M
