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

---@param opts? table
function M.tasks(opts)
  opts = opts or {}

  -- Ensure asynctasks.vim is loaded (it's lazy-loaded)
  require("lazy").load({ plugins = { "asynctasks.vim" } })

  ---@type table[]
  local ok, tasks = pcall(vim.api.nvim_call_function, "asynctasks#source", { math.floor(vim.o.columns * 48 / 100) })
  if not ok then
    vim.notify("Failed to load asynctasks", vim.log.levels.ERROR)
    return
  end
  if not tasks or vim.tbl_isempty(tasks) then
    vim.notify("No asynctasks found for current buffer", vim.log.levels.WARN)
    return
  end

  -- Build entries: each task is a list of fields, joined with " | "
  local entries = {}
  for i = 1, #tasks do
    local current_task = table.concat(tasks[i], " | ")
    table.insert(entries, {
      task = tasks[i],
      text = current_task, -- required: used by the matcher for filtering/searching
      value = current_task,
      name = tasks[i][1],
      display = current_task,
    })
  end

  Snacks.picker({
    title = "AsyncTasks",
    items = entries,
    format = function(item, _picker)
      return { { item.display, "SnacksPickerLabel" } }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item or not item.name then
        return
      end
      local cmd = table.concat({ "AsyncTask", item.name }, " ")
      vim.cmd(cmd)
    end,
  })
end

return M
