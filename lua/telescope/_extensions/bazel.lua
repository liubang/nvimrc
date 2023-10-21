-- =====================================================================
--
-- bazel.lua -
--
-- Created by liubang on 2021/01/03 19:02
-- Last Modified: 2022/12/04 17:11
--
-- =====================================================================
local actions = require 'telescope.actions'
local actions_state = require 'telescope.actions.state'
local finders = require 'telescope.finders'
local pickers = require 'telescope.pickers'
local sorters = require 'telescope.sorters'
local telescope = require 'telescope'
local util = require 'lb.utils.util'

local bazel_finder = function(opts, title, kind)
    -- check if bazel installed
    if vim.fn.executable 'bazel' ~= 1 then
        vim.notify('You need to install bazel', vim.log.levels.ERROR)
        return
    end

    local root = util.root_pattern 'WORKSPACE'(vim.fn.expand '%:p')
    if root == '' or 0 == vim.fn.filereadable(string.format('%s/WORKSPACE', vim.fn.expand(root))) then
        vim.notify(
            'The bazel command is only supported within a workspace (below a directory having a WORKSPACE file)',
            vim.log.levels.ERROR
        )
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
    pickers
        .new(opts, {
            prompt_title = title,
            sorter = sorters.get_fzy_sorter(opts),
            finder = finders.new_oneshot_job(find_command, opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    local selection = actions_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    if selection.value ~= '' then
                        local cmd = 'AsyncRun -mode=term -pos=floaterm'
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
        })
        :find()
end

local bazel_build = function(opts)
    bazel_finder(opts, 'BazelBuild', '')
end

local bazel_tests = function(opts)
    bazel_finder(opts, 'BazelTest', '.*_test')
end

local bazel_run = function(opts)
    bazel_finder(opts, 'BazelRun', '.*_binary')
end

local bazel_cc_rules = function(opts)
    bazel_finder(opts, 'BazelCCBuild', 'cc_.*')
end

local bazel_cc_tests = function(opts)
    bazel_finder(opts, 'BazelCCTest', 'cc_test')
end

local bazel_cc_run = function(opts)
    bazel_finder(opts, 'BazelCCRun', 'cc_run')
end

return telescope.register_extension {
    exports = {
        bazel_run = bazel_run,
        bazel_build = bazel_build,
        bazel_tests = bazel_tests,
        bazel_cc_run = bazel_cc_run,
        bazel_cc_rules = bazel_cc_rules,
        bazel_cc_tests = bazel_cc_tests,
    },
}
