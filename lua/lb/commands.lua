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

vim.api.nvim_create_user_command("Filepath", function() -- {{{
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.notify(vim.fn.expand("%:p"), vim.log.levels.INFO, {
    title = "Filename",
    timeout = 3000,
  })
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("YankFilename", function() -- {{{
  vim.fn.setreg('"', vim.fn.expand("%:t"))
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("YankFilepath", function() -- {{{
  vim.fn.setreg('"', vim.fn.expand("%:p"))
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("CopyRight", function() -- {{{
  require("lb.utils.comment").copy_right()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("AddFileHeader", function() -- {{{
  require("lb.utils.comment").add_fileheader()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("CopyRightApache", function() -- {{{
  require("lb.utils.comment").copy_right_apache()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("TrimWhiteSpace", function() -- {{{
  require("lb.utils.util").trim_whitespace()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("DocUpdate", function() -- {{{
  require("lb.utils.doc").update()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("Tasks", function() -- {{{
  require("telescope").extensions.tasks.tasks()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("BazelBuild", function() -- {{{
  require("telescope").extensions.bazel.bazel_build()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("BazelRun", function() -- {{{
  require("telescope").extensions.bazel.bazel_run()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("BazelTests", function() -- {{{
  require("telescope").extensions.bazel.bazel_tests()
end, { nargs = 0 }) -- }}}

-- vim: fdm=marker fdl=0
