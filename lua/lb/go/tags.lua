--=====================================================================
--
-- tags.lua -
--
-- Created by liubang on 2022/07/09 02:21
-- Last Modified: 2022/07/09 02:21
--
--=====================================================================

local M = {}
local gomodify = 'gomodifytags'

M.modify = function(...)
  local fname = vim.fn.expand '%' -- %:p:h ? %:p
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local ns = require('lb.ts.go').get_struct_node_at_pos(row, col)
  if require('lb.utils.objects').empty(ns) then
    return
  end

  local struct_name = ns.name
  local setup = { gomodify, '-format', 'json', '-file', fname, '-w' }

  if struct_name == nil then
    local _, csrow, _, _ = unpack(vim.fn.getpos '.')
    table.insert(setup, '-line')
    table.insert(setup, csrow)
  else
    table.insert(setup, '-struct')
    table.insert(setup, struct_name)
  end

  local arg = { ... }

  for _, v in ipairs(arg) do
    table.insert(setup, v)
  end

  if #arg == 1 and arg[1] ~= '-clear-tags' then
    table.insert(setup, 'json')
  end

  vim.fn.jobstart(setup, {
    on_stdout = function(_, data, _)
      data = require('lb.utils.job').handle_job_data(data)
      if not data then
        return
      end
      local tagged = vim.fn.json_decode(data)
      if
        tagged.errors ~= nil
        or tagged.lines == nil
        or tagged['start'] == nil
        or tagged['start'] == 0
      then
        vim.notify('failed to set tags' .. vim.inspect(tagged), vim.lsp.log_levels.ERROR)
      end
      for index, value in ipairs(tagged.lines) do
        tagged.lines[index] = require('lb.utils.string').rtrim(value)
      end
      vim.api.nvim_buf_set_lines(
        0,
        tagged['start'] - 1,
        tagged['start'] - 1 + #tagged.lines,
        false,
        tagged.lines
      )
      vim.cmd 'write'
      vim.notify('struct updated ', vim.lsp.log_levels.DEBUG)
    end,
  })
end

-- e.g {"json,xml", "-transform", "camelcase"}
M.add = function(...)
  local cmd = { '-add-tags' }
  local arg = { ... }
  if #arg == 0 then
    arg = { 'json' }
  end

  for _, v in ipairs(arg) do
    table.insert(cmd, v)
  end

  M.modify(unpack(cmd))
end

M.rm = function(...)
  local cmd = { '-remove-tags' }
  local arg = { ... }
  if #arg == 0 then
    arg = { 'json' }
  end
  for _, v in ipairs(arg) do
    table.insert(cmd, v)
  end
  M.modify(unpack(cmd))
end

M.clear = function()
  local cmd = { '-clear-tags' }
  M.modify(unpack(cmd))
end

return M
