--=====================================================================
--
-- tests.lua -
--
-- Created by liubang on 2022/09/24 13:25
-- Last Modified: 2022/09/24 13:25
--
--=====================================================================

local tsgo = require 'lb.ts.go'

local M = {}

M.run_file = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local tree = vim.treesitter.get_parser(bufnr):parse()[1]
  local query = vim.treesitter.parse_query('go', tsgo.query_test_func)

  local test_names = {}
  for id, node, _ in query:iter_captures(tree:root(), bufnr, 0, -1) do
    local name = query.captures[id]
    if name == 'test_name' then
      table.insert(test_names, vim.treesitter.get_node_text(node, bufnr))
    end
  end

  vim.schedule(function()
    vim.lsp.buf.execute_command {
      command = 'gopls.run_tests',
      arguments = { { URI = vim.uri_from_bufnr(0), Tests = test_names } },
    }
  end)
end

M.list_tests = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local tree = vim.treesitter.get_parser(bufnr):parse()[1]
  local query = vim.treesitter.parse_query('go', tsgo.query_test_func)

  local test_names = {}
  for id, node, _ in query:iter_captures(tree:root(), bufnr, 0, -1) do
    local name = query.captures[id]
    if name == 'test_name' then
      table.insert(test_names, vim.treesitter.get_node_text(node, bufnr))
    end
  end

  vim.ui.select(test_names, {
    prompt = 'Select Test Function',
  }, function(choice)
    vim.schedule(function()
      vim.lsp.buf.execute_command {
        command = 'gopls.run_tests',
        arguments = { { URI = vim.uri_from_bufnr(0), Tests = { choice } } },
      }
    end)
  end)
end

return M
