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

return {
  "skywind3000/asynctasks.vim", -- {{{
  dependencies = {
    { "skywind3000/asyncrun.vim" },
  },
  cmd = { "AsyncTask", "AsyncRun" },
  config = function() -- {{{
    vim.g.asyncrun_bell = 1
    vim.g.asyncrun_rootmarks = { ".svn", ".git", ".root", "build.xml" }
    vim.g.asynctasks_term_pos = "floaterm"
  end, -- }}}
  keys = {
    { "<C-b>", "<CMD>AsyncTask file-build<CR>", mode = { "n" }, desc = "Build current file" },
    { "<C-r>", "<CMD>AsyncTask file-run<CR>", mode = { "n" }, desc = "Run current file" },
    { "<C-x>", "<CMD>AsyncTask file-build-run<CR>", mode = { "n" }, desc = "Build and run current file" },
  },
  -- }}}
}
