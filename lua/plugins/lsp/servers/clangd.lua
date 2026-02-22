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

local function get_default_drivers(binaries)
  if vim.env["CLANGD_DRIVERS"] then
    return vim.env["CLANGD_DRIVERS"]
  end
  local path_list = {}
  for _, binary in ipairs(binaries) do
    local path = vim.fn.exepath(binary)
    if path ~= "" then
      table.insert(path_list, path)
    end
  end
  return table.concat(path_list, ",")
end

local luv = vim.uv
local cpu = luv.available_parallelism()

local function get_clangd_cmd()
  local cmd = {
    "clangd",
    "-j=" .. (cpu / 2),
    "--background-index",
    "--pch-storage=memory",
    "--function-arg-placeholders",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--query-driver=" .. get_default_drivers({ "clang++", "clang", "gcc", "g++" }),
    "--enable-config",
    "--fallback-style=google",
    "--limit-references=1000",
    "--limit-results=300",
    "--log=error",
  }
  if not require("lb.utils.util").is_mac then
    table.insert(cmd, "--malloc-trim")
  end
  return cmd
end

--- Implements the off-spec textDocument/switchSourceHeader method.
--- @param buf integer
local function switch_source_header(client, buf)
  client:request("textDocument/switchSourceHeader", vim.lsp.util.make_text_document_params(buf), function(err, result)
    if err then
      vim.notify(err.message, vim.log.levels.ERROR)
      return
    end
    if not result then
      vim.notify("Corresponding file could not be determined", vim.log.levels.WARN)
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end)
end

return {
  cmd = get_clangd_cmd(),
  -- disable proto type
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
  },
  settings = {
    clangd = {
      Completion = {
        CodePatterns = "NONE",
      },
    },
  },
  capabilities = {
    offsetEncoding = { "utf-8", "utf-16" },
  },
  on_attach = function(client, buf)
    vim.api.nvim_buf_create_user_command(buf, "ClangdSwitchSourceHeader", function()
      switch_source_header(client, buf)
    end, {
      bar = true,
      desc = "clangd: Switch Between Source and Header File",
    })
    vim.keymap.set("n", "grs", "<Cmd>ClangdSwitchSourceHeader<CR>", {
      buffer = buf,
      desc = "clangd: Switch Between Source and Header File",
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("conf_lsp_attach_detach", { clear = false }),
      buffer = buf,
      callback = function(args)
        if args.data.client_id == client.id then
          vim.keymap.del("n", "grs", { buffer = buf })
          vim.api.nvim_buf_del_user_command(buf, "ClangdSwitchSourceHeader")
          return true -- Delete this autocmd.
        end
      end,
    })
  end,
}
