--=====================================================================
--
-- gopls.lua -
--
-- Created by liubang on 2022/09/21 22:07
-- Last Modified: 2022/12/11 00:09
--
--=====================================================================

local M = {}
local cmds = {}

-- @Ref https://go.googlesource.com/tools/+/refs/heads/master/gopls/doc/commands.md
local gopls_cmds = {
  -- "gopls.add_dependency",
  -- "gopls.add_import",
  -- "gopls.apply_fix",
  -- "gopls.check_upgrades",
  -- "gopls.gc_details",
  -- "gopls.generate",
  -- "gopls.generate_gopls_mod",
  "gopls.go_get_package",
  "gopls.list_known_packages",
  -- "gopls.list_imports",
  -- "gopls.regenerate_cgo",
  -- "gopls.remove_dependency",
  -- "gopls.run_tests",
  -- "gopls.start_debugging",
  -- "gopls.test",
  "gopls.tidy",
  -- "gopls.toggle_gc_details",
  -- "gopls.update_go_sum",
  -- "gopls.upgrade_dependency",
  -- "gopls.vendor",
  -- "gopls.workspace_metadata",
}

local gopls_with_result = {
  -- "gopls.gc_details",
  "gopls.list_known_packages",
  -- "gopls.list_imports",
}

for _, value in ipairs(gopls_cmds) do
  local fname = string.sub(value, #"gopls." + 1)
  cmds[fname] = function(arg)
    local b = vim.api.nvim_get_current_buf()
    local uri = vim.uri_from_bufnr(b)
    local arguments = { { URI = uri } }

    local ft = vim.bo.filetype
    if ft == "gomod" or ft == "gosum" then
      arguments = { { URIs = { uri } } }
    end

    arguments = { vim.tbl_extend("keep", arguments[1], arg or {}) }
    if vim.tbl_contains(gopls_with_result, value) then
      local resp = vim.lsp.buf_request_sync(b, "workspace/executeCommand", {
        command = value,
        arguments = arguments,
      }, 2000)
      return resp
    end

    vim.schedule(function()
      vim.lsp.buf.execute_command {
        command = value,
        arguments = arguments,
      }
    end)
  end
end

M.list_pkgs = function()
  local resp = cmds.list_known_packages() or {}

  local pkgs = {}
  for _, response in pairs(resp) do
    if response.result ~= nil then
      pkgs = response.result.Packages
      break
    end
  end
  return pkgs
end

M.tidy = function()
  cmds.tidy()
end

local client = function()
  local clients = vim.lsp.get_active_clients()
  for _, cl in pairs(clients) do
    if cl.name == "gopls" then
      return cl
    end
  end
end

local codeaction = function(action, only, wait_ms)
  wait_ms = wait_ms or 1000
  local params = vim.lsp.util.make_range_params()
  if only then
    params.context = { only = { only } }
  end

  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  if not result or next(result) == nil then
    return
  end

  local c = client()
  for _, res in pairs(result) do
    for _, r in pairs(res.result or {}) do
      if r.edit and not vim.tbl_isempty(r.edit) then
        vim.lsp.util.apply_workspace_edit(r.edit, c.offset_encoding)
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

M.org_imports = function(wait_ms)
  codeaction("", "source.organizeImports", wait_ms)
  vim.lsp.buf.format { async = false, timeout_ms = wait_ms }
end

return M
