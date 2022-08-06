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
  error 'This plugins require nvim-telescope/telescope.nvim'
end

local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local actions = require 'telescope.actions'
local themes = require 'telescope.themes'
local state = require 'telescope.actions.state'
local entry_display = require 'telescope.pickers.entry_display'

local configs = {}
local setup = function(setup_config)
  if setup_config.theme and setup_config.theme ~= '' then
    configs = themes['get_' .. setup_config.theme]()
  end
  configs = vim.tbl_deep_extend('force', configs, setup_config or {})
end

local tasks = function(opts)
  opts = vim.tbl_deep_extend('force', configs, opts or {})

  local tasks =
    vim.api.nvim_call_function('asynctasks#source', { math.floor(vim.o.columns * 48 / 100) })

  if vim.tbl_isempty(tasks) then
    return
  end

  local plugin_name_width = 0
  local entries = {}

  for i = 1, #tasks do
    local current_task = table.concat(tasks[i], '')
    plugin_name_width = #current_task > plugin_name_width and #current_task or plugin_name_width
    table.insert(entries, current_task)
  end

  local displayer = entry_display.create {
    separator = '',
    items = {
      { width = plugin_name_width + 1 },
      { remaining = true },
    },
  }

  local make_display = function(entry)
    return displayer {
      { entry.name, hl, 'Normal' },
    }
  end

  pickers
    .new(opts, {
      prompt_title = 'Tasks',
      finder = finders.new_table {
        results = entries,
        entry_maker = function(entry)
          return {
            value = entry,
            display = make_display,
            ordinal = entry,
            name = entry,
          }
        end,
      },

      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        local start_task = function()
          local selection = state.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)
          local task_name = tasks[selection.index][1]
          local cmd = table.concat({ 'AsyncTask', task_name }, ' ')
          vim.cmd(cmd)
        end

        map('i', '<CR>', start_task)
        map('n', '<CR>', start_task)

        return true
      end,
    })
    :find()
end

return telescope.register_extension {
  setup = setup,
  exports = { tasks = tasks },
}
