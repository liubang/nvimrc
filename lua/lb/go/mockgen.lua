--=====================================================================
--
-- mockgen.lua -
--
-- Created by liubang on 2022/09/22 20:20
-- Last Modified: 2022/12/11 00:09
--
--=====================================================================

local mockgen = "mockgen"
local tsgo = require "lb.ts.go"
local util = require "lb.utils.util"
local package = require "lb.go.package"
local gopts = require "lb.go.opts"
local Job = require "plenary.job"

-- notify title
local title = { title = "GoMockgen" }

-- use ts to get name
local function get_interface_name()
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

local run = function(opts)
  local long_opts = {
    package = "p",
    source = "s",
    destination = "d",
    interface = "i",
  }

  local short_opts = "p:d:i:s"
  local args = opts.fargs or {}

  local optarg, _, _ = gopts.get_opts(args, short_opts, long_opts)
  local mockgen_args = { mockgen }
  local sep = util.sep()
  local ifname = get_interface_name()

  assert(optarg ~= nil)

  if optarg["i"] ~= nil and #optarg["i"] > 0 then
    ifname = optarg["i"]
  end

  if optarg["s"] ~= nil then
    ifname = ""
  end
  local fpath = util.rel_path(true)
  local sname = vim.fn.expand "%:t"

  if fpath ~= "" then
    fpath = fpath .. sep
  end

  if ifname == "" or ifname == nil then
    -- source mode default
    table.insert(mockgen_args, "-source")
    table.insert(mockgen_args, fpath .. sname)
  else
    -- need to get the import path
    local bufnr = vim.api.nvim_get_current_buf()
    local pkg = package.pkg_from_path(nil, bufnr)
    if pkg ~= nil and type(pkg) == "table" and pkg[1] then
      table.insert(mockgen_args, pkg[1])
    else
      table.insert(mockgen_args, ".")
    end
    table.insert(mockgen_args, ifname)
  end

  local pkgname = optarg["p"] or "mocks"
  table.insert(mockgen_args, "-package")
  table.insert(mockgen_args, pkgname)

  local dname = fpath .. pkgname .. sep .. "mock_" .. sname
  table.insert(mockgen_args, "-destination")
  table.insert(mockgen_args, dname)

  local job = Job:new {
    command = mockgen,
    args = mockgen_args,
  }
  local data = job:sync()
  if job.code ~= 0 then
    vim.notify("mockgen failed exit code " .. job.code, vim.log.levels.ERROR, title)
    return
  end
  vim.notify(
    "mockgen " .. table.concat(mockgen_args, " ") .. " finished\n" .. table.concat(data, "\n"),
    vim.log.levels.INOF,
    title
  )
end

return { run = run }
