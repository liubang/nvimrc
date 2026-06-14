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

local configured = false

local function get_capabilities()
  local ok, blink = pcall(require, "blink.cmp")
  if ok and blink.get_lsp_capabilities then
    return blink.get_lsp_capabilities()
  end
  return vim.lsp.protocol.make_client_capabilities()
end

local function merge_capabilities(server_capabilities)
  return vim.tbl_deep_extend("force", get_capabilities(), server_capabilities or {})
end

local function compose_on_attach(default_on_attach, server_on_attach)
  if not server_on_attach then
    return default_on_attach
  end

  return function(client, bufnr)
    default_on_attach(client, bufnr)
    server_on_attach(client, bufnr)
  end
end

function M.on_attach(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- stylua: ignore start
  vim.keymap.set("n", "<Leader>gd", function() Snacks.picker.lsp_definitions() end, bufopts)
  vim.keymap.set("n", "<Leader>gi", function() Snacks.picker.lsp_implementations() end, bufopts)
  vim.keymap.set("n", "<Leader>gr", function() Snacks.picker.lsp_references() end, bufopts)
  vim.keymap.set("n", "<Leader>gD", function() Snacks.picker.lsp_declarations() end, bufopts)
  vim.keymap.set("n", "<Leader>gy", function() Snacks.picker.lsp_type_definitions() end, bufopts)
  vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<Leader>es", function() Snacks.picker.diagnostics_buffer() end, bufopts)
  vim.keymap.set("n", "<Leader>ee", function() vim.diagnostic.open_float({ scope = "line" }) end, bufopts)
  vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.hover({ height = 15, width = 100, max_height = 20, max_width = 140, border = "rounded" }) end, bufopts)
  vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help({ height = 15, width = 100, max_height = 20, max_width = 140, border = "rounded" }) end, bufopts)
  vim.keymap.set("n", "<Leader>eS", function() Snacks.picker.diagnostics() end, bufopts)
  -- stylua: ignore end
end

function M.extend(server_opts)
  server_opts = server_opts or {}

  local merged = vim.tbl_deep_extend("force", {
    capabilities = get_capabilities(),
  }, server_opts)

  merged.capabilities = merge_capabilities(server_opts.capabilities)
  merged.on_attach = compose_on_attach(M.on_attach, server_opts.on_attach)

  return merged
end

function M.enable(server, server_opts)
  vim.lsp.config(server, M.extend(server_opts))
  vim.lsp.enable(server)
end

function M.setup()
  if configured then
    return
  end
  configured = true

  vim.diagnostic.config({
    source = true,
    signs = true,
    virtual_text = false,
    severity_sort = true,
    update_in_insert = false,
    underline = false,
    float = {
      spacing = 4,
      border = "rounded",
      focusable = true,
      header = { " Diagnostics ", "Title" },
      max_width = 80,
      prefix = " ",
      scope = "line",
      source = true,
      suffix = " ",
    },
  })

  vim.lsp.handlers["textDocument/documentHighlight"] = function() end
end

return M
