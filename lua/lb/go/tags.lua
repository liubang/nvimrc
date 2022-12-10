--=====================================================================
--
-- tags.lua -
--
-- Created by liubang on 2022/07/09 02:21
-- Last Modified: 2022/12/11 00:09
--
--=====================================================================
local gomodify = "gomodifytags"
local tsgo = require "lb.ts.go"
local Job = require "plenary.job"

local tags = {}
-- notify title
local title = { title = "GoModifyTags" }

local empty = function(t)
  if t == nil then
    return true
  end
  if type(t) ~= "table" then
    return false
  end
  return next(t) == nil
end

tags.modify = function(...)
  local fname = vim.fn.expand "%:p"
  local ns = tsgo.get_struct_node_at_pos()
  if empty(ns) then
    return
  end

  local struct_name = ns.name
  local args = { "-format", "json", "-file", fname, "-w" }

  if struct_name == nil then
    local _, csrow, _, _ = unpack(vim.fn.getpos ".")
    table.insert(args, "-line")
    table.insert(args, csrow)
  else
    table.insert(args, "-struct")
    table.insert(args, struct_name)
  end

  local arg = { ... }

  for _, v in ipairs(arg) do
    table.insert(args, v)
  end

  if #arg == 1 and arg[1] ~= "-clear-tags" then
    table.insert(args, "json")
  end

  local job = Job:new {
    command = gomodify,
    args = args,
  }

  local data = job:sync()
  if job.code ~= 0 then
    vim.notify("modifytags failed exit code " .. job.code, vim.log.levels.ERROR, title)
    return
  end
  data = table.concat(data, "")
  local json = vim.fn.json_decode(data)
  if json == nil or json.lines == nil then
    return
  end
  for idx, value in ipairs(json.lines) do
    json.lines[idx] = require("lb.utils.util").rtrim(value)
  end
  vim.api.nvim_buf_set_lines(0, json["start"] - 1, json["start"] - 1 + #json.lines, false, json.lines)
  vim.cmd.write()
  vim.notify("struct updated", vim.log.levels.DEBUG, title)
end

-- e.g {"json,xml", "-transform", "camelcase"}
tags.add = function(...)
  local cmd = { "-add-tags" }
  local arg = { ... }
  if #arg == 0 then
    arg = { "json" }
  end

  for _, v in ipairs(arg) do
    table.insert(cmd, v)
  end

  tags.modify(unpack(cmd))
end

tags.rm = function(...)
  local cmd = { "-remove-tags" }
  local arg = { ... }
  if #arg == 0 then
    arg = { "json" }
  end
  for _, v in ipairs(arg) do
    table.insert(cmd, v)
  end
  tags.modify(unpack(cmd))
end

tags.clear = function()
  local cmd = { "-clear-tags" }
  tags.modify(unpack(cmd))
end

return tags
