--=====================================================================
--
-- mockgen.lua -
--
-- Created by liubang on 2022/09/22 20:20
-- Last Modified: 2022/09/22 20:20
--
--=====================================================================

local mockgen = 'mockgen'
local tsgo = require 'lb.ts.go'
local util = require 'lb.utils.util'
local job = require 'lb.utils.job'
local runner = require 'lb.go.runner'
local package = require 'lb.go.package'
local gopts = require 'lb.go.opts'

-- use ts to get name
local function get_interface_name()
  local name = tsgo.get_interface_node_at_pos()
  if name == nil then
    return ''
  end
  local node_name = name.name
  local dim = name.dim.e
  local r, c = dim.r, dim.c
  vim.api.nvim_win_set_cursor(0, { r, c })
  return node_name
end

local run = function(opts)
  local long_opts = {
    package = 'p',
    source = 's',
    destination = 'd',
    interface = 'i',
  }

  local short_opts = 'p:d:i:s'
  local args = opts.fargs or {}

  local optarg, _, _ = gopts.get_opts(args, short_opts, long_opts)
  local mockgen_cmd = { mockgen }
  local sep = util.sep()
  local ifname = get_interface_name()

  assert(optarg ~= nil)

  if optarg['i'] ~= nil and #optarg['i'] > 0 then
    ifname = optarg['i']
  end

  if optarg['s'] ~= nil then
    ifname = ''
  end
  local fpath = util.rel_path(true)
  local sname = vim.fn.expand '%:t'

  if fpath ~= '' then
    fpath = fpath .. sep
  end

  if ifname == '' or ifname == nil then
    -- source mode default
    table.insert(mockgen_cmd, '-source')
    table.insert(mockgen_cmd, fpath .. sname)
  else
    -- need to get the import path
    local bufnr = vim.api.nvim_get_current_buf()
    local pkg = package.pkg_from_path(nil, bufnr)
    if pkg ~= nil and type(pkg) == 'table' and pkg[1] then
      table.insert(mockgen_cmd, pkg[1])
    else
      table.insert(mockgen_cmd, '.')
    end
    table.insert(mockgen_cmd, ifname)
  end

  local pkgname = optarg['p'] or 'mocks'
  table.insert(mockgen_cmd, '-package')
  table.insert(mockgen_cmd, pkgname)

  local dname = fpath .. pkgname .. sep .. 'mock_' .. sname
  table.insert(mockgen_cmd, '-destination')
  table.insert(mockgen_cmd, dname)

  local mock_opts = {
    on_exit = function(code, signal, data)
      if code ~= 0 or signal ~= 0 then
        return
      end
      data = vim.split(data, '\n')
      data = job.handle_job_data(data)
      if not data then
        return
      end
      vim.schedule(function()
        vim.notify(
          vim.fn.join(mockgen_cmd, ' ') .. ' finished ' .. vim.fn.join(data, ' '),
          vim.log.levels.INFO
        )
      end)
    end,
  }
  runner.run(mockgen_cmd, mock_opts)
  return mockgen_cmd
end

return { run = run }
