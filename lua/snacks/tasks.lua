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

function M.tasks()
  require("lazy").load({ plugins = { "asynctasks.vim" } })

  local ok, tasks = pcall(vim.api.nvim_call_function, "asynctasks#source", { math.floor(vim.o.columns * 48 / 100) })
  if not ok then
    vim.notify("Failed to load asynctasks", vim.log.levels.ERROR)
    return
  end
  if not tasks or vim.tbl_isempty(tasks) then
    vim.notify("No asynctasks found for current buffer", vim.log.levels.WARN)
    return
  end

  local entries = {}
  for i = 1, #tasks do
    local t = tasks[i]
    table.insert(entries, {
      name = t[1], -- task name
      cmd = t[2], -- task command
      text = table.concat(t, " | "),
      value = t[1],
    })
  end

  Snacks.picker({
    title = "AsyncTasks",
    items = entries,
    format = function(item, _picker)
      return { { item.text, "SnacksPickerLabel" } }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item or not item.name then
        return
      end
      vim.cmd(string.format([[TermExec cmd='%s' direction=horizontal go_back=0]], item.cmd))
    end,
  })
end

return M
