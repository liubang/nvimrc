-- =====================================================================
--
-- async_tasks.lua -
--
-- Created by liubang on 2021/01/03 19:02
-- Last Modified: 2022/12/29 09:03
--
-- =====================================================================
local has_telescope, telescope = pcall(require, "telescope")
if not has_telescope then
  error "This plugins require nvim-telescope/telescope.nvim"
end

local finders = require "telescope.finders"
local pickers = require "telescope.pickers"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local state = require "telescope.actions.state"

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
      finder = finders.new_table {
        results = entries,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry.value,
            ordinal = entry.task[1],
            name = entry.task[1],
          }
        end,
      },
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

return telescope.register_extension {
  exports = { tasks = tasks },
}
