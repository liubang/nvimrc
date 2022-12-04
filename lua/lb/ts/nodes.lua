--=====================================================================
--
-- nodes.lua -
--
-- Created by liubang on 2022/07/09 02:07
-- Last Modified: 2022/07/09 02:07
--
--=====================================================================

local ts_utils = require "nvim-treesitter.ts_utils"
local ts_query = require "nvim-treesitter.query"
local parsers = require "nvim-treesitter.parsers"
local locals = require "nvim-treesitter.locals"

local M = {}

local function get_node_text(bufnr, node)
  if vim.treesitter.query ~= nil and vim.treesitter.query.get_node_text ~= nil then
    return vim.treesitter.query.get_node_text(bufnr, node)
  end
  return ts_utils.get_node_text(node)[1]
end

M.get_all_nodes = function(query, lang, bufnr, type_only)
  bufnr = bufnr or 0
  local success, parsed_query = pcall(function()
    return vim.treesitter.parse_query(lang, query)
  end)
  if not success then
    return nil
  end
  local parser = parsers.get_parser(bufnr, lang)
  local root = parser:parse()[1]:root()
  local start_row, _, end_row, _ = root:range()
  local results = {}
  local node_type
  for match in ts_query.iter_prepared_matches(parsed_query, root, bufnr, start_row, end_row) do
    local sRow, sCol, eRow, eCol
    local declaration_node
    local type_node
    local type = ""
    local name = ""
    local op = ""
    locals.recurse_local_nodes(match, function(_, node, path)
      local idx = string.find(path, ".[^.]*$") -- find last `.`
      op = string.sub(path, idx + 1, #path)
      local dbg_txt = get_node_text(node, bufnr) or ""
      if #dbg_txt > 100 then
        dbg_txt = string.sub(dbg_txt, 1, 100) .. "..."
      end
      type = string.sub(path, 1, idx - 1) -- e.g. struct.name, type is struct
      if type:find "type" and op == "type" then -- type_declaration.type
        node_type = get_node_text(node, bufnr)
      end
      -- may not handle complex node
      if op == "name" then
        name = get_node_text(node, bufnr) or ""
        type_node = node
      elseif op == "declaration" or op == "clause" then
        declaration_node = node
        sRow, sCol, eRow, eCol = ts_utils.get_vim_range({ ts_utils.get_node_range(node) }, bufnr)
      else
        -- vim.notify('unknown op: ' .. op, vim.log.levels.WARN)
      end
    end)
    if declaration_node ~= nil then
      table.insert(results, {
        declaring_node = declaration_node,
        dim = { s = { r = sRow, c = sCol }, e = { r = eRow, c = eCol } },
        name = name,
        operator = op,
        type = node_type or type,
      })
    end
    if type_node ~= nil and type_only then
      sRow, sCol, eRow, eCol = ts_utils.get_vim_range({ ts_utils.get_node_range(type_node) }, bufnr)
      table.insert(results, {
        type_node = type_node,
        dim = { s = { r = sRow, c = sCol }, e = { r = eRow, c = eCol } },
        name = name,
        operator = op,
        type = type,
      })
    end
  end
  return results
end

local intersects = function(row, col, sRow, sCol, eRow, eCol)
  -- ulog(row, col, sRow, sCol, eRow, eCol)
  if sRow > row or eRow < row then
    return false
  end

  if sRow == row and sCol > col then
    return false
  end

  if eRow == row and eCol < col then
    return false
  end

  return true
end

M.count_parents = function(node)
  local count = 0
  local n = node.declaring_node
  while n ~= nil do
    n = n:parent()
    count = count + 1
  end
  return count
end

M.intersect_nodes = function(nodes, row, col)
  local found = {}
  for idx = 1, #nodes do
    local node = nodes[idx]
    local sRow = node.dim.s.r
    local sCol = node.dim.s.c
    local eRow = node.dim.e.r
    local eCol = node.dim.e.c

    if intersects(row, col, sRow, sCol, eRow, eCol) then
      table.insert(found, node)
    end
  end

  return found
end

M.sort_nodes = function(nodes)
  table.sort(nodes, function(a, b)
    return M.count_parents(a) < M.count_parents(b)
  end)
  return nodes
end

M.nodes_at_cursor = function(query, bufnr)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row, col = row, col + 1
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "ft")
  local nodes = M.get_all_nodes(query, ft, bufnr)
  if nodes == nil then
    vim.notify("Unable to find any nodes. place your cursor on a go symbol and try again", vim.log.levels.DEBUG)
    return nil
  end

  local nodes_at_cursor = M.sort_nodes(M.intersect_nodes(nodes, row, col))
  if nodes_at_cursor == nil or #nodes_at_cursor == 0 then
    vim.notify("Unable to find any nodes at pos. " .. tostring(row) .. ":" .. tostring(col), vim.log.levels.DEBUG)
    return nil
  end

  return nodes_at_cursor
end

M.nodes_in_buf = function(query, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ft = vim.api.nvim_buf_get_option(bufnr, "ft")
  local nodes = M.get_all_nodes(query, ft, bufnr, true)
  if nodes == nil then
    vim.notify("Unable to find any nodes.", vim.log.levels.ERROR)
    return nil
  end
  return nodes
end

return M
