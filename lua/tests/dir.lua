--=====================================================================
--
-- dir.lua -
--
-- Created by liubang on 2022/12/04 03:54
-- Last Modified: 2022/12/04 03:54
--
--=====================================================================

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
