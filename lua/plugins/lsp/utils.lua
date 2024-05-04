-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

local M = {}

function M.codeaction(client, action, only, wait_ms)
  wait_ms = wait_ms or 1000
  local params = vim.lsp.util.make_range_params()
  if only then
    params.context = { only = { only } }
  end

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  if not result or next(result) == nil then
    return
  end

  for _, res in pairs(result) do
    for _, r in pairs(res.result or {}) do
      if r.edit and not vim.tbl_isempty(r.edit) then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-32")
      end
      if type(r.command) == "table" then
        if type(r.command) == "table" and r.command.arguments then
          for _, arg in pairs(r.command.arguments) do
            if action == nil or arg["Fix"] == action then
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
