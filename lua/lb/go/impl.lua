--=====================================================================
--
-- impl.lua -
--
-- Created by liubang on 2022/09/21 21:36
-- Last Modified: 2022/09/21 21:36
--
--=====================================================================
local tsgo = require 'lb.ts.go'
local gopackage = require 'lb.go.package'
local job = require 'lb.utils.job'
local runner = require 'lb.go.runner'
local gopls = require 'lb.go.gopls'
local tsnodes = require 'lb.ts.nodes'
local impl = 'impl'

local function get_type_name()
  local name = tsgo.get_struct_node_at_pos()
  if name == nil then
    name = tsgo.get_type_node_at_pos()
  end
  if name == nil then
    return ''
  end
  local node_name = name.name
  -- let move the cursor to end of line of struct name
  local dim = name.dim.e
  -- let move cursor
  local r, c = dim.r, dim.c
  vim.api.nvim_win_set_cursor(0, { r, c })
  return node_name
end

local function get_interface_name()
  local name = tsgo.get_interface_node_at_pos()
  if name == nil then
    return nil
  end
  local node_name = name.name
  -- let move the cursor to end of line of struct name
  local dim = name.dim.e
  -- let move cursor
  local r, c = dim.r, dim.c
  vim.api.nvim_win_set_cursor(0, { r, c })
  local pkg = gopackage.pkg_from_path(nil, vim.api.nvim_get_current_buf())
  if pkg then
    return pkg[1] .. '.' .. node_name
  end
end

local run = function(...)
  local iface = ''
  local recv_name = ''
  local arg = { ... }

  local recv = get_type_name()
  iface = get_interface_name()

  if #arg == 0 then
    iface = vim.fn.input 'Impl: generating method stubs for interface: '
    vim.cmd 'redraw!'
    if iface == '' then
      vim.notify(
        'Impl: please input interface name e.g. io.Reader or receiver name e.g. GoImpl MyType',
        log.levels.WARN
      )
    end
  elseif #arg == 1 then
    -- " i.e: ':GoImpl io.Writer'
    if iface ~= nil then
      recv = select(1, ...)
      recv = string.lower(recv) .. ' *' .. recv
    else
      recv = string.lower(recv) .. ' *' .. recv
      iface = select(1, ...)
    end
    if recv == '' and iface == '' then
      vim.notify(
        'put cursor on struct or a interface or specify a receiver & interface',
        vim.log.levels.WARN
      )
    end
    vim.cmd 'redraw!'
  elseif #arg == 2 then
    if iface ~= nil then
      recv = select(1, ...)
      local recv_type = select(2, ...)
      recv = string.lower(recv) .. ' *' .. recv_type
    else
      recv_name = select(1, ...)
      recv = string.format('%s *%s', recv_name, recv)
      local l = #arg
      iface = select(l, ...)
    end
  elseif #arg > 2 then
    local l = #arg
    iface = select(l, ...)
    recv = select(l - 1, ...)
    recv_name = select(l - 2, ...)
    recv = string.format('%s %s', recv_name, recv)
  end

  local dir = vim.fn.fnameescape(vim.fn.expand '%:p:h')
  local impl_cmd = { impl, '-dir', dir, recv, iface }
  local opts = {
    update_buffer = true,
    on_exit = function(code, signal, data)
      if code ~= 0 or signal ~= 0 then
        vim.notify('impl failed' .. vim.inspect(data))
        return
      end
      data = vim.split(data, '\n')
      data = job.handle_job_data(data)
      if not data then
        return
      end
      vim.schedule(function()
        local pos = vim.fn.getcurpos()[2]
        table.insert(data, 1, '')
        vim.fn.append(pos, data)
      end)
    end,
  }
  runner.run(impl_cmd, opts)
end

local function match_iface_name(part)
  local pkg, iface = string.match(part, '^(.*)%.(.*)$')
  local cmd = string.format('go doc %s', pkg)
  local doc = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify('go doc failed' .. vim.inspect(doc), vim.log.levels.WARN)
    return
  end

  local ifaces = {}
  local pat = string.format('^type (%s.*) interface', iface)
  for _, line in ipairs(doc) do
    local m = string.match(line, pat)
    if m ~= nil then
      table.insert(ifaces, string.format('%s.%s', pkg, m))
    end
  end
  return ifaces
end

local function complete(_, cmdline, _)
  local words = vim.split(cmdline, [[%s+]])
  local last = words[#words]
  local iface = get_interface_name()
  local query = tsgo.query_type_declaration
  local bufnr = vim.api.nvim_get_current_buf()
  if iface ~= nil then
    local nodes = tsnodes.nodes_in_buf(query, bufnr)
    local ns = {}
    for _, node in ipairs(nodes) do
      table.insert(ns, node.name)
    end
    return vim.fn.uniq(ns)
  end

  if string.match(last, '^.+%..*') ~= nil then
    local part = match_iface_name(last)
    if part ~= nil then
      return part
    end
  end

  return vim.fn.uniq(vim.fn.sort(gopls.list_pkgs()))
end

return { run = run, complete = complete }
