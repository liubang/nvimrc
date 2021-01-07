-- =====================================================================
--
-- bazel.lua - 
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

local bazel_finder = function(opts, title, kind)
  if 1 ~= vim.fn.executable('bazel') then
    print('You need to install bazel')
    return
  end
  opts = opts or {}
  local find_command = {}
  if kind == 'rules' then
    find_command = {
      'bazel', 
      'query', 
      'kind("rule", //...)', 
      '--keep_going', 
      '--noshow_progress', 
      '--output=label'
    }
  elseif kind == 'tests' then
    find_command = {
      'bazel',
      'query',
      'kind(".*_test rule", //...)',
      '--keep_going',
      '--noshow_progress',
      '--output=label',
    }
  elseif kind == 'binaries' then
    find_command = {
      'bazel',
      'query',
      'kind(".*_binary rule", //...)',
      '--keep_going',
      '--noshow_progress',
      '--output=label',
    }
  end

  pickers.new(opts, {
    prompt_title = title,
    finder = finders.new_oneshot_job(find_command, opts),
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.goto_file_selection_edit:replace(function()
        local selection = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection.value ~= '' then
          vim.cmd(string.format('AsyncRun -mode=term -pos=right bazel build %s', selection.value))
        end
      end)
      return true
    end,
  }):find()
end

local bazel_rules = function(opts)
  bazel_finder(opts, 'BazelRules', 'rules')
end

local bazel_tests = function(opts)
  bazel_finder(opts, 'BazelTests', 'tests')
end

local bazel_binaries = function(opts)
  bazel_finder(opts, 'BazelBinaries', 'binaries')
end

return telescope.register_extension {
  exports = {
    bazel_rules = bazel_rules, 
    bazel_tests = bazel_tests, 
    bazel_binaries = bazel_binaries
  },
}
