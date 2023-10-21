--=====================================================================
--
-- utils.lua -
--
-- Created by liubang on 2023/09/15 23:25
-- Last Modified: 2023/09/15 23:25
--
--=====================================================================
local M = {}

function M.codeaction(client, action, only, wait_ms)
    wait_ms = wait_ms or 1000
    local params = vim.lsp.util.make_range_params()
    if only then
        params.context = { only = { only } }
    end

    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, wait_ms)
    if not result or next(result) == nil then
        return
    end

    for _, res in pairs(result) do
        for _, r in pairs(res.result or {}) do
            if r.edit and not vim.tbl_isempty(r.edit) then
                vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
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
