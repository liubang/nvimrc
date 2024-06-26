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
local actions_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local telescope = require("telescope")
local util = require("lb.utils.util")

local bazel_finder = function(opts, title, kind)
  -- check if bazel installed
  if vim.fn.executable("bazel") ~= 1 then
    vim.notify("You need to install bazel", vim.log.levels.ERROR)
    return
  end

  local root = util.root_pattern("WORKSPACE", "MODULE.bazel", "WORKSPACE.bzlmod")(vim.fn.expand("%:p"))
  if root == "" then
    vim.notify(
      "The bazel command is only supported within a workspace (below a directory having a WORKSPACE file)",
      vim.log.levels.ERROR
    )
    return
  end

  opts = opts or {}
  local find_command = {
    "bazel",
    "query",
    string.format('kind("%s rule", //...)', kind),
    "--keep_going",
    "--noshow_progress",
    "--output=label",
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
          if selection.value ~= "" then
            local cmd = "AsyncRun -mode=term -pos=floaterm"
            if kind:match("test") ~= nil then
              cmd = string.format("%s bazel test %s", cmd, selection.value)
            elseif kind:match("binary") ~= nil then
              cmd = string.format("%s bazel run %s", cmd, selection.value)
            else
              cmd = string.format("%s bazel build %s", cmd, selection.value)
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
  bazel_finder(opts, "BazelBuild", "")
end

local bazel_tests = function(opts)
  bazel_finder(opts, "BazelTest", ".*_test")
end

local bazel_run = function(opts)
  bazel_finder(opts, "BazelRun", ".*_binary")
end

local bazel_cc_rules = function(opts)
  bazel_finder(opts, "BazelCCBuild", "cc_.*")
end

local bazel_cc_tests = function(opts)
  bazel_finder(opts, "BazelCCTest", "cc_test")
end

local bazel_cc_run = function(opts)
  bazel_finder(opts, "BazelCCRun", "cc_run")
end

return telescope.register_extension({
  exports = {
    bazel_run = bazel_run,
    bazel_build = bazel_build,
    bazel_tests = bazel_tests,
    bazel_cc_run = bazel_cc_run,
    bazel_cc_rules = bazel_cc_rules,
    bazel_cc_tests = bazel_cc_tests,
  },
})
