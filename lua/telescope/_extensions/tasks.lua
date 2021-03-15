-- =====================================================================
--
-- async_tasks.lua - 
--
-- Created by liubang on 2021/01/03 19:02
-- Last Modified: 2021/01/03 19:02
--
-- =====================================================================
local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
  error('This plugins require nvim-telescope/telescope.nvim')
end

local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

local task_lists = function()
  if vim.fn['asynctasks#source'] == nil then
    return {}
  end
  local keymaps = '123456789abcdefimopqrstuvwxyz'
  local items = vim.fn['asynctasks#source'](vim.o.columns * 48 / 100)
  local size = #keymaps
  local index = 0
  local result = {}
  for _, item in ipairs(items) do
    local key = ''
    local text = '[ ]'
    if index < size then
      key = vim.fn.strpart(keymaps, index, 1)
      text = string.format('[%s]\t', key)
    end
    text = string.format('%s%s\t%s\t%s', text, item[1], item[2], item[3])
    local value = string.format('AsyncTask %s', item[1])
    table.insert(result, {display = text, value = value, ordinal = string.format('%s %s', key, item[1])})
    index = index + 1
  end
  return result
end

local tasks = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = 'AsyncTasks',
    finder = finders.new_table {
      results = task_lists(),
      entry_maker = function(entry)
        return {value = entry.value, display = entry.display, ordinal = entry.ordinal}
      end,
    },
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection.value ~= '' then
          vim.cmd(selection.value)
        end
      end)
      return true
    end,
  }):find()
end

return telescope.register_extension {exports = {tasks = tasks}}
