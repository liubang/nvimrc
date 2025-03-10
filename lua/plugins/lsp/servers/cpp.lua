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

local Job = require("plenary.job")
local c = require("plugins.lsp.customs")
local lspconfig = require("lspconfig")
local is_mac = vim.loop.os_uname().version:match("Darwin")

local function get_binary_path(bin)
  local j = Job:new({ command = "which", args = { bin } })
  local _, result = pcall(function()
    local out = j:sync()
    if #out > 0 then
      return vim.trim(out[1])
    end
    return nil
  end)
  return result
end

local function get_default_drivers(binaries)
  local path_list = {}
  for _, binary in ipairs(binaries) do
    local path = get_binary_path(binary)
    if path then
      table.insert(path_list, path)
    end
  end
  return table.concat(path_list, ",")
end

local luv = require("luv")
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
    "--limit-references=3000",
    "--limit-results=350",
    "--log=error",
  }
  if not is_mac then
    table.insert(cmd, "--malloc-trim")
  end
  return cmd
end

lspconfig.clangd.setup(c.default({
  cmd = get_clangd_cmd(),
  -- disable proto type
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
  },
  capabilities = {
    offsetEncoding = { "utf-16" },
  },
}))
