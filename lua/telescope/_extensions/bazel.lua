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
  error 'This plugins require nvim-telescope/telescope.nvim'
end

local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local actions = require 'telescope.actions'

local bazel_finder = function(opts, title, kind)
  -- check if bazel installed
  if 1 ~= vim.fn.executable 'bazel' then
    print 'ERROR: You need to install bazel'
    return
  end

  local root = vim.fn['asyncrun#get_root'](vim.fn.expand '%', { 'WORKSPACE' }, 1)
  if root == '' or 0 == vim.fn.filereadable(string.format('%s/WORKSPACE', vim.fn.expand(root))) then
    print 'ERROR: The "bazel" command is only supported from within a workspace (below a directory having a WORKSPACE file).'
    return
  end

  opts = opts or {}
  local find_command = {
    'bazel',
    'query',
    string.format('kind("%s rule", //...)', kind),
    '--keep_going',
    '--noshow_progress',
    '--output=label',
  }

  pickers.new(opts, {
    prompt_title = title,
    finder = finders.new_oneshot_job(find_command, opts),
    sorter = sorters.get_fzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = actions.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection.value ~= '' then
          local cmd = 'AsyncRun -mode=term -pos=right'
          if kind:match 'test' ~= nil then
            cmd = string.format('%s bazel test %s', cmd, selection.value)
          elseif kind:match 'binary' ~= nil then
            cmd = string.format('%s bazel run %s', cmd, selection.value)
          else
            cmd = string.format('%s bazel build %s', cmd, selection.value)
          end
          vim.cmd(cmd)
        end
      end)
      return true
    end,
  }):find()
end

local bazel_rules = function(opts)
  bazel_finder(opts, 'BazelRules', '')
end

local bazel_tests = function(opts)
  bazel_finder(opts, 'BazelTests', '.*_test')
end

local bazel_binaries = function(opts)
  bazel_finder(opts, 'BazelBinaries', '.*_binary')
end

local bazel_cc_rules = function(opts)
  bazel_finder(opts, 'BazelCCRules', 'cc_.*')
end

local bazel_cc_tests = function(opts)
  bazel_finder(opts, 'BazelCCTests', 'cc_test')
end

local bazel_cc_binaries = function(opts)
  bazel_finder(opts, 'BazelCCBinaries', 'cc_binary')
end

return telescope.register_extension {
  exports = {
    bazel_rules = bazel_rules,
    bazel_tests = bazel_tests,
    bazel_binaries = bazel_binaries,
    bazel_cc_rules = bazel_cc_rules,
    bazel_cc_tests = bazel_cc_tests,
    bazel_cc_binaries = bazel_cc_binaries,
  },
}
