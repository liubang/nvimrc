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

local Docs = require("lazy.docs")
local Util = require("lazy.util")
local core = require("lazy.core.plugin").Spec.new({ import = "plugins" })
local root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h:h:h:h")

local keymaps = function()
  local keymaps = {}
  local group = nil
  local groups = {}
  local keymap_set = vim.keymap.set

  local function map(mode, lhs, _, opts)
    if not (opts and opts.desc) then
      return
    end
    if not vim.tbl_contains(groups, group) then
      groups[#groups + 1] = group
    end
    mode = mode == nil and { "n", "v", "o" } or type(mode) == "string" and { mode } or mode
    local desc = opts and opts.desc or ""
    local key = lhs .. desc .. group
    if keymaps[key] then
      vim.list_extend(keymaps[key].mode, mode)
    else
      keymaps[key] = { mode = mode, keys = lhs, desc = desc, i = vim.tbl_count(keymaps), group = group }
    end
  end

  -- hack vim.keymap.set
  vim.keymap.set = map

  do
    group = "General"
    dofile(root .. "/lua/lb/mappings.lua")
  end

  -- reset vim.keymap.set function
  vim.keymap.set = keymap_set

  do
    group = "Plugins"
    Util.foreach(core.plugins, function(_, plugin)
      if type(plugin.keys) == "table" then
        for _, key in ipairs(plugin.keys or {}) do
          if type(key) == "table" and key.desc then
            local desc = key.desc or ""
            desc = ("[%s](%s)"):format(plugin.name, plugin.url) .. " " .. desc
            map(key.mode or "n", key[1], key[2], { desc = desc })
          end
        end
      end
    end)
  end

  ---@type string[]
  local lines = {}
  vim.list_extend(lines, { "| Key | Description | Mode |", "| --- | --- | --- |" })

  for _, g in ipairs(groups) do
    local mappings = vim.tbl_filter(function(m)
      return m.group == g and m.desc
    end, keymaps)

    table.sort(mappings, function(a, b)
      return a.i < b.i
    end)

    for _, m in ipairs(mappings) do
      lines[#lines + 1] = "| ``"
        .. m.keys:gsub("|", "\\|"):gsub("`$", "` ")
        .. "`` | "
        .. m.desc
        .. " | "
        .. table.concat(
          vim.tbl_map(function(mode)
            return "**" .. mode .. "**"
          end, m.mode),
          ", "
        )
        .. " |"
    end
  end
  return { content = table.concat(lines, "\n") }
end

--- update README.md file
local update = function()
  local data = {
    keymaps = keymaps(),
    plugins = {
      content = Docs.plugins(core.plugins).content,
    },
  }
  Docs.save(data)
end

return {
  update = update,
}
