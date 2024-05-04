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

local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local state = require("telescope.actions.state")
local telescope = require("telescope")

local tasks = function(opts)
  local tasks = vim.api.nvim_call_function("asynctasks#source", { math.floor(vim.o.columns * 48 / 100) })
  if vim.tbl_isempty(tasks) then
    return
  end

  local entries = {}
  for i = 1, #tasks do
    local current_task = table.concat(tasks[i], " | ")
    table.insert(entries, { task = tasks[i], value = current_task })
  end

  pickers
    .new(opts, {
      prompt_title = "AsyncTasks",
      sorter = sorters.get_fzy_sorter(opts),
      finder = finders.new_table({
        results = entries,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.value,
            ordinal = entry.task[1],
            name = entry.task[1],
          }
        end,
      }),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          local selection = state.get_selected_entry()
          actions.close(prompt_bufnr)
          local task_name = selection.name
          local cmd = table.concat({ "AsyncTask", task_name }, " ")
          vim.cmd(cmd)
        end)
        return true
      end,
    })
    :find()
end

return telescope.register_extension({
  exports = { tasks = tasks },
})
