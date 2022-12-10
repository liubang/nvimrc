--=====================================================================
--
-- mockgen.lua -
--
-- Created by liubang on 2022/09/22 20:20
-- Last Modified: 2022/12/11 03:32
--
--=====================================================================
local mockgen = "mockgen"
local tsgo = require "lb.ts.go"
local util = require "lb.utils.util"
local package = require "lb.go.package"
local Job = require "plenary.job"

-- notify title
local title = { title = "GoMockgen" }

-- use ts to get name
local get_interface_name = function()
  local name = tsgo.get_interface_node_at_pos()
  if name == nil then
    return ""
  end
  local node_name = name.name
  local dim = name.dim.e
  local r, c = dim.r, dim.c
  vim.api.nvim_win_set_cursor(0, { r, c })
  return node_name
end

local parse_args = function(args)
  if not args then
    return
  end
  local parsed = {}
  for _, v in pairs(args) do
    local kv = vim.fn.split(v, "=")
    if #kv == 2 then
      if kv[1]:sub(1, 2) == "--" then
        parsed[kv[1]:sub(3)] = kv[2]
      end
    end
  end
  return parsed
end

local run = function(opts)
  local args = parse_args(opts.fargs or {}) or {}

  local cmd_args = {}
  local ifname = ""
  local sep = util.sep()
  local fpath = util.rel_path(true) .. sep
  local fname = vim.fn.expand "%:t"
  local pkgname = args["package"] or "mocks"
  local dest = args["destination"] or fpath .. pkgname .. sep .. "mock_" .. fname

  table.insert(cmd_args, "-package")
  table.insert(cmd_args, pkgname)
  table.insert(cmd_args, "-destination")
  table.insert(cmd_args, dest)

  -- use reflect mode
  if args["source"] == nil then
    ifname = get_interface_name()
    if ifname == "" then
    end
  end

  if ifname == "" then
    -- use source mode
    table.insert(cmd_args, "-source")
    table.insert(cmd_args, fpath .. sep .. fname)
  else
    -- use reflect mode
    local pkg = package.pkg_from_path(nil, vim.api.nvim_get_current_buf())
    if pkg ~= nil and pkg[1] then
      table.insert(cmd_args, pkg[1])
    else
      table.insert(cmd_args, ".")
    end
    table.insert(cmd_args, ifname)
  end

  local job = Job:new {
    command = mockgen,
    args = cmd_args,
  }
  job:sync()

  if job.code ~= 0 then
    vim.notify("mockgen failed " .. job.code, vim.log.levels.ERROR, title)
    return
  end

  vim.notify("mockgen finished", vim.log.levels.INFO, title)
end

return { run = run }
