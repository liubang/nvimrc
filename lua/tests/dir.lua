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

local util = require("lb.utils.util")
local root = util.root_pattern(".git", "init.lua", "task.ini")(vim.fn.expand("%:p"))
-- vim.pretty_print(vim.fn.expand "%")
local fpath = vim.fn.expand("%:p")
vim.pretty_print(fpath)
vim.pretty_print(root)

vim.pretty_print(fpath:find(root, 1, true))

local a = "/mnt/workspace/go/process-exporter/proc"
local b = "/mnt/workspace/go/process-exporter"

vim.pretty_print(a)
vim.pretty_print(b)

vim.pretty_print(a:find(b, 1, true))
local s, e, _ = a:find(b, 1, true)

vim.pretty_print(a:sub(e + 1))
