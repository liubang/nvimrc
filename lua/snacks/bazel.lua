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
-- Created: 2026/06/14 10:44

local M = {}

local function get_bazel_root()
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    path = vim.uv.cwd()
  end
  return vim.fs.root(path, {
    "MODULE.bazel",
    "WORKSPACE",
    "WORKSPACE.bazel",
    "WORKSPACE.bzlmod",
  })
end

local function run_in_toggleterm(cmd, cwd)
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({
    cmd = cmd,
    dir = cwd,
    direction = "horizontal",
    hidden = true,
    close_on_exit = false,
  }):open()
end

---@param title string
---@param kind string|nil Bazel rule kind pattern (e.g. "cc_test", ".*_test")
---@param action string Bazel action (build, test, run)
local function bazel_finder(title, kind, action)
  if vim.fn.executable("bazel") ~= 1 then
    vim.notify("You need to install bazel", vim.log.levels.ERROR)
    return
  end

  local root = get_bazel_root()
  if not root then
    vim.notify("The bazel command is only supported within a Bazel workspace", vim.log.levels.ERROR)
    return
  end

  local query
  if kind == nil or kind == "" then
    query = 'kind(".* rule", //...)'
  else
    query = string.format('kind("%s rule", //...)', kind)
  end

  local find_command = {
    "bazel",
    "query",
    query,
    "--keep_going",
    "--noshow_progress",
    "--output=label",
  }

  vim.system(find_command, { cwd = root, text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 and (not result.stdout or result.stdout == "") then
        local message = vim.trim(result.stderr or "bazel query failed")
        vim.notify(message, vim.log.levels.ERROR)
        return
      end

      local items = {}
      for line in (result.stdout or ""):gmatch("[^\r\n]+") do
        local clean = line:gsub("\27%[[%d;]*%a", "")
        if clean ~= "" then
          items[#items + 1] = { text = clean, value = clean }
        end
      end

      Snacks.picker({
        title = title,
        items = items,
        format = function(item, _picker)
          return { { item.value, "SnacksPickerLabel" } }
        end,
        confirm = function(picker, item)
          picker:close()
          if not item or not item.value or item.value == "" then
            return
          end
          local cmd = string.format("bazel %s %s", action, vim.fn.shellescape(item.value))
          run_in_toggleterm(cmd, root)
        end,
      })
    end)
  end)
end

function M.build()
  bazel_finder("BazelBuild", "", "build")
end

function M.test()
  bazel_finder("BazelTest", ".*_test", "test")
end

function M.run()
  bazel_finder("BazelRun", ".*_binary", "run")
end

return M
