--=====================================================================
--
-- lsp.lua -
--
-- Created by liubang on 2022/09/03 02:31
-- Last Modified: 2022/09/03 02:31
--
--=====================================================================

local M = {}

function M.client_by_name(name)
  local clients = vim.lsp.get_active_clients()
  for _, cl in pairs(clients) do
    if cl.name == name then
      return cl
    end
  end
end

M.codeaction = function(clname, action, only, wait_ms)
  wait_ms = wait_ms or 1000
  local params = vim.lsp.util.make_range_params()
  if only then
    params.context = { only = { only } }
  end
  local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
  if not result or next(result) == nil then
    print 'nil result'
    return
  end
  local c = M.client_by_name(clname)
  for _, res in pairs(result) do
    for _, r in pairs(res.result or {}) do
      if r.edit and not vim.tbl_isempty(r.edit) then
        vim.lsp.util.apply_workspace_edit(r.edit, c.offset_encoding)
      end
      if type(r.command) == 'table' then
        if type(r.command) == 'table' and r.command.arguments then
          for _, arg in pairs(r.command.arguments) do
            if action == nil or arg['Fix'] == action then
              vim.lsp.buf.execute_command(r.command)
              return
            end
          end
        end
      end
    end
  end
end

return M
