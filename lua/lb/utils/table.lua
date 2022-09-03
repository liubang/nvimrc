--=====================================================================
--
-- table.lua -
--
-- Created by liubang on 2022/09/04 00:28
-- Last Modified: 2022/09/04 00:28
--
--=====================================================================

--- https://github.com/arsham/arshlib.nvim/blob/master/lua/arshlib/tables.lua

---Inherits from all parents.
---@param cls Table
---@param parents any[]
local function inherit(cls, parents) --{{{
  cls.__index = cls
  cls.__super = parents
  local cls_parents = {
    __index = function(_, key)
      for i = 1, #parents do
        local found = parents[i][key]
        if found then
          return found
        end
      end
    end,
  }
  setmetatable(cls, cls_parents)
  setmetatable(parents, cls_parents)
end --}}}

---@class Table : table
---@field __super tablelib
local Table = {}
inherit(Table, { table })

---Creates a new Table from the given table.
---@param t table?
---@return Table|table|tablelib
Table.new = function(t) --{{{
  return setmetatable(t or {}, Table)
end --}}}

-- selene: allow(global_usage)
local _t = Table.new
Table.__call = Table.new

Table.__tostring = function(self) --{{{
  local ret = {}
  for k, v in pairs(self) do
    local value = tostring(v)
    if type(v) == 'string' then
      value = '"' .. v .. '"'
    end
    table.insert(ret, string.format('%s: %s', tostring(k), value))
  end
  return string.format('{%s}', table.concat(ret, ', '))
end --}}}

---Compares two tables for equality. It does not care about the named orders,
-- however it greatly cares about the order of the index keys.
---@param self Table
---@param other Table
---@return boolean
Table.__eq = function(self, other) --{{{
  if type(other) ~= 'Table' then
    other = Table.new(other)
  end
  if #self ~= #other then
    return false
  end
  for k in pairs(self) do
    if self[k] ~= other[k] then
      return false
    end
  end
  return true
end --}}}

---Filters the table if the function returns true.
---@param self Table
---@param fn fun(v: any):boolean
function Table:filter(fn) --{{{
  assert(type(fn) == 'function', 'filter: func must be a function')
  local ret = _t()
  local cur_index = 0
  for k, v in pairs(self) do
    local ok, new_val = fn(v)
    if ok then
      if type(k) == 'number' then
        cur_index = cur_index + 1
        ret[cur_index] = new_val or v
      else
        ret[k] = new_val or v
      end
    end
  end
  return ret
end --}}}

---Runs the function for each item in the table.
---@param self Table
---@param fn fun(v: any, k?:any):any the key is passed for convenience.
function Table:map(fn) --{{{
  assert(type(fn) == 'function', 'map: func must be a function')
  local ret = _t()
  for k, v in pairs(self) do
    ret[k] = fn(v, k)
  end
  return ret
end --}}}

---Returns a new Table that contains only the values of the table.
function Table:values() --{{{
  local ret = _t()
  for _, v in pairs(self) do
    ret:insert(v)
  end
  return ret
end --}}}

---Returns a new Table that contains only the keys of the table.
function Table:keys() --{{{
  local ret = _t()
  for k, _ in pairs(self) do
    ret:insert(k)
  end
  return ret
end --}}}

---Returns parts of the table between first and last indices. It does not take
-- the named keys into account.
---@param first number
---@param last? number
---@param step? number the step between each index
function Table:slice(first, last, step) --{{{
  step = step or 1
  if step == 1 then
    return _t { unpack(self, first, last) }
  end
  local sliced = _t {}
  local length = #self
  last = last or #self
  for i = first or 1, last or length, step do
    sliced[#sliced + 1] = self[i]
  end
  return sliced
end --}}}

---Merge two tables. Note that the new indices of the second table will be
-- adjusted to the first table.
---@param other Table
---@param self Table
---@param dup boolean|nil if true it will duplicate indexed values.
function Table:merge(other, dup) --{{{
  local tmp = _t(vim.deepcopy(self))
  local seen = _t()
  for k, v in pairs(self) do
    if type(k) == 'number' then
      seen[v] = true
    end
  end

  for k, v in pairs(other) do
    if type(k) == 'string' then
      tmp[k] = v
    else
      if dup or not seen[v] then
        table.insert(tmp, v)
      end
    end
  end

  return tmp
end --}}}

---Returns the first entry for which the fn functions returns true. If the
-- returned value is nil, you should check the boolean value of the returned to
-- determine if the value was found or not.
---@param fn fun(v: any):boolean
---@return any
---@return boolean
function Table:find_first(fn) --{{{
  assert(type(fn) == 'function', 'filter: func must be a function')
  for _, item in pairs(self) do
    if fn(item) then
      return item, true
    end
  end
  return nil, false
end --}}}

---Check if the fn returns true for at least one entry of the table.
---@param fn fun(v: any):boolean calls on each entry of t
---@return boolean
function Table:contains_fn(fn) --{{{
  assert(type(fn) == 'function', 'filter: func must be a function')
  local item, ok = self:find_first(fn)
  return ok and item ~= nil
end --}}}

---Return true of the table contains the value.
---@param val any
---@return boolean
function Table:contains(val) --{{{
  if val ~= nil and type(val) == 'table' then
    val = _t(val)
  end
  return self:contains_fn(function(v)
    if type(v) == 'table' then
      return _t(v) == val
    end
    return v == val
  end)
end --}}}

---Return a reversed the table. Note that it only works on the numeric indices.
---@param self Table
function Table:reverse() --{{{
  local reversed = _t()
  local itemCount = #self
  for k, v in pairs(self) do
    if type(k) == 'number' then
      reversed[itemCount + 1 - k] = v
    else
      reversed[k] = v
    end
  end
  return reversed
end --}}}

math.randomseed(os.time())
function Table:shuffle() --{{{
  local ret = _t(self)
  local iterations = #ret
  local j
  for i = iterations, 2, -1 do
    j = math.random(i)
    ret[i], ret[j] = ret[j], ret[i]
  end
  return ret
end --}}}

---Returns a table containing chucks of the given table by chuck size.{{{
---@param size number
---@usage
-- local t = _t{11, 22, 3, 4, 5, 6, 7, 8, a=9, b=10}
-- local chunks = t:chunk(3)
-- for _, chunk in ipairs(chunks) do
--     print(table.concat(chunk, ", "))
--     --- prints: 1=11, 2=22, 3=3
--     ---         1=4, 2=5, 3=6
--     ---         1=7, 2=8, a=9
--     ---         b=10
--  end
-- }}}
function Table:chunk(size) --{{{
  if size == 0 then
    return _t { vim.deepcopy(self) }
  end
  local ret = _t()
  local cur_chunk = 1
  local cur_size = 0
  for k, v in pairs(self) do
    cur_size = cur_size + 1
    if cur_size > size then
      cur_chunk = cur_chunk + 1
      cur_size = 1
    end
    ret[cur_chunk] = ret[cur_chunk] or _t()
    if type(k) == 'number' then
      local key = k - ((cur_chunk - 1) * size)
      ret[cur_chunk][key] = v
    else
      ret[cur_chunk][k] = v
    end
  end
  return ret
end --}}}

---Returns a unique set of the table. It only operates on the indexed keys.
---@param fn? fun(v: any):any mutate values if provided and returns not nil.
function Table:unique(fn) --{{{
  if type(fn) ~= 'function' then
    fn = nil
  end
  fn = fn or function(v)
    return v
  end
  local ret = _t()
  local seen = _t()
  for _, v in ipairs(self) do
    v = fn(v) or v
    if not seen[v] then
      ret:insert(v)
    end
    seen[v] = true
  end
  return ret
end --}}}

---Sorts list elements in a given order and returns a new Table.
---@param fn fun(a: any, b: any):boolean
function Table:sort(fn) --{{{
  local ret = _t(vim.deepcopy(self))
  self.__super.sort(ret, fn)
  return ret
end --}}}

---Executes the fn function on the whole table and returns a new Table.
---@param fn fun(v: any):any will pass the Table to the function.
function Table:exec(fn) --{{{
  return _t(fn(self))
end --}}}

---Returns the Table if the v condition is true. Otherwise returns an empty
-- Table.
---@param v boolean
---@return Table
function Table:when(v) --{{{
  return v and self or _t {}
end --}}}

---Returns the length of the table inclusing the map items.
---@return number
function Table:map_length() --{{{
  local ret = 0
  for _, _ in pairs(self) do
    ret = ret + 1
  end
  return ret
end --}}}

return Table

-- vim: fdm=marker fdl=0
