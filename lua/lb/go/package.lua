--=====================================================================
--
-- package.lua -
--
-- Created by liubang on 2022/09/21 21:45
-- Last Modified: 2022/12/11 03:32
--
--=====================================================================
local Job = require "plenary.job"
local M = {}

M.pkg_from_path = function(pkg, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local cwd = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ":p:h")
  local args = { "list" }
  if pkg ~= nil then
    table.insert(args, pkg)
  end

  local job = Job:new {
    command = "go",
    args = args,
    cwd = cwd,
  }

  local output = job:sync()
  if job.code ~= 0 then
    vim.notify("execute go" .. table.concat(args, " ") .. " failed")
    return
  end

  return output
end

return M
