--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2022/04/05 01:46
-- Last Modified: 2022/04/05 01:46
--
--=====================================================================

local M = {}
local highlight_ns = vim.api.nvim_create_namespace "jdtls_hl"

function M.open_jdt_link(uri)
  local client
  for _, c in ipairs(vim.lsp.get_active_clients()) do
    if
      c.config.init_options
      and c.config.init_options.extendedClientCapabilities
      and c.config.init_options.extendedClientCapabilities.classFileContentsSupport
    then
      client = c
      break
    end
  end
  assert(client, "Must have a buffer open with a language client connected to eclipse.jdt.ls to load JDT URI")
  local buf = vim.api.nvim_get_current_buf()
  local params = {
    uri = uri,
  }
  local response = nil
  local cb = function(err, result)
    response = { err, result }
  end
  local ok, request_id = client.request("java/classFileContents", params, cb, buf)
  assert(ok, "Request to `java/classFileContents` must succeed to open JDT URI. Client shutdown?")
  local timeout_ms = 5000
  local wait_ok, reason = vim.wait(timeout_ms, function()
    return response
  end)
  local log_path = vim.fn.stdpath "cache" .. "/lsp.log"
  local buf_content
  if wait_ok and #response == 2 and response[2] then
    local content = response[2]
    if content == "" then
      buf_content = {
        "Received response from server, but it was empty. Check the log file for errors",
        log_path,
      }
    else
      buf_content = vim.split(response[2], "\n", true)
    end
  else
    local error_msg
    if not wait_ok then
      client.cancel_request(request_id)
      local wait_failure = {
        [-1] = "timeout",
        [-2] = "interrupted",
        [-3] = "error",
      }
      error_msg = wait_failure[reason]
    else
      error_msg = response[1]
    end
    buf_content = {
      "Failed to load content for uri",
      uri,
      "",
      "Error was: ",
    }
    vim.list_extend(buf_content, vim.split(vim.inspect(error_msg), "\n"))
    vim.list_extend(buf_content, { "", "Check the log file for errors", log_path })
  end
  vim.api.nvim_buf_set_option(buf, "modifiable", true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, buf_content)
  vim.api.nvim_buf_set_option(0, "filetype", "java")
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

local function find_last(str, pattern)
  local idx = nil
  while true do
    local i = string.find(str, pattern, (idx or 0) + 1)
    if i == nil then
      break
    else
      idx = i
    end
  end
  return idx
end

local function java_generate_to_string_prompt(_, outer_ctx)
  local params = outer_ctx.params
  vim.lsp.buf_request(0, "java/checkToStringStatus", params, function(err, result, ctx)
    if err then
      print("Could not execute java/checkToStringStatus: " .. err.message)
      return
    end
    if not result then
      return
    end
    if result.exists then
      local choice = vim.fn["quickui#confirm#open"](
        string.format("Method 'toString()' already exists in '%s'. Do you want to replace it?", result.type),
        "&Replace\n&Cancel",
        1,
        "Confirm"
      )
      if choice < 1 or choice == 2 then
        return
      end
    end
    local lines = {}
    for _, field in pairs(result.fields) do
      table.insert(lines, string.format("%s: %s", field.name, field.type))
    end
    local idxs = vim.fn["quickui#checkbox#open"](lines, {
      title = "Select Fields",
    })
    local fields = {}
    for _, idx in pairs(idxs) do
      table.insert(fields, result.fields[tonumber(idx) + 1])
    end
    vim.lsp.buf_request(ctx.bufnr, "java/generateToString", { context = params, fields = fields }, function(e, edit)
      if e then
        print("Could not execute java/generateToString: " .. e.message)
        return
      end
      if edit then
        vim.lsp.util.apply_workspace_edit(edit, "utf-16")
      end
    end)
  end)
end

local function java_generate_constructors_prompt(_, outer_ctx)
  vim.lsp.buf_request(0, "java/checkConstructorsStatus", outer_ctx.params, function(err0, status, ctx)
    if err0 then
      print("Could not execute java/checkConstructorsStatus: " .. err0.message)
      return
    end
    if not status or not status.constructors or #status.constructors == 0 then
      return
    end
    local constructors = status.constructors
    if #status.constructors > 1 then
      local lines = {}
      for _, x in pairs(status.constructors) do
        table.insert(lines, string.format("%s(%s)", x.name, table.concat(x.parameters, ",")))
      end
      local idxs = vim.fn["quickui#checkbox#open"](lines, {
        title = "Select Constructors",
      })
      local selected = {}
      for _, idx in pairs(idxs) do
        table.insert(selected, constructors[tonumber(idx) + 1])
      end
      constructors = selected
    end

    local fields = status.fields
    if fields then
      local lines = {}
      for _, x in pairs(fields) do
        table.insert(lines, string.format("%s: %s", x.name, x.type))
      end
      local idxs = vim.fn["quickui#checkbox#open"](lines, {
        title = "Select Parameters",
      })
      local selected = {}
      for _, idx in pairs(idxs) do
        table.insert(selected, fields[tonumber(idx) + 1])
      end
      fields = selected
    end

    local params = {
      context = outer_ctx.params,
      constructors = constructors,
      fields = fields,
    }
    vim.lsp.buf_request(ctx.bufnr, "java/generateConstructors", params, function(err1, edit)
      if err1 then
        print("Could not execute java/generateConstructors: " .. err1.message)
      elseif edit then
        vim.lsp.util.apply_workspace_edit(edit, "utf-16")
      end
    end)
  end)
end

local function java_generate_delegate_methods_prompt(_, outer_ctx)
  vim.lsp.buf_request(0, "java/checkDelegateMethodsStatus", outer_ctx.params, function(err0, status, ctx)
    if err0 then
      print("Could not execute java/checkDelegateMethodsStatus: ", err0.message)
      return
    end
    if not status or not status.delegateFields or #status.delegateFields == 0 then
      print "All delegatable methods are already implemented."
      return
    end

    local field
    if #status.delegateFields == 1 then
      field = status.delegateFields[1]
    elseif #status.delegateFields > 1 then
      local lines = {}
      for _, x in pairs(status.delegateFields) do
        table.insert(lines, string.format("%s: %s", x.field.name, x.field.type))
      end
      local idx = vim.fn["quickui#listbox#inputlist"](lines, {
        index = -1,
        title = "Select target to generate delegate for",
      })
      field = status.delegateFields[idx + 1]
    end

    if not field then
      return
    end
    if #field.delegateMethods == 0 then
      print "All delegatable methods are already implemented."
      return
    end

    local lines = {}
    for _, x in pairs(field.delegateMethods) do
      table.insert(lines, string.format("%s(%s)", x.name, table.concat(x.parameters, ",")))
    end
    local idxs = vim.fn["quickui#checkbox#open"](lines, { title = "Generate delegate for methods" })
    local methods = {}
    for _, idx in pairs(idxs) do
      table.insert(methods, field.delegateMethods[tonumber(idx) + 1])
    end
    if not methods or #methods == 0 then
      return
    end

    local params = {
      context = outer_ctx.params,
      delegateEntries = vim.tbl_map(function(x)
        return {
          field = field.field,
          delegateMethod = x,
        }
      end, methods),
    }
    vim.lsp.buf_request(ctx.bufnr, "java/generateDelegateMethods", params, function(err1, workspace_edit)
      if err1 then
        print("Could not execute java/generateDelegateMethods", err1.message)
      elseif workspace_edit then
        vim.lsp.util.apply_workspace_edit(workspace_edit, "utf-16")
      end
    end)
  end)
end

local function java_hash_code_equals_prompt(_, outer_ctx)
  local params = outer_ctx.params
  vim.lsp.buf_request(0, "java/checkHashCodeEqualsStatus", params, function(_, result, ctx)
    if not result or not result.fields or #result.fields == 0 then
      print(string.format("The operation is not applicable to the type %", result.type))
      return
    end
    local lines = {}
    for _, x in pairs(result.fields) do
      table.insert(lines, string.format("%s: %s", x.name, x.type))
    end
    local idxs = vim.fn["quickui#checkbox#open"](lines, { title = "Select Fields" })
    local fields = {}
    for _, idx in pairs(idxs) do
      table.insert(fields, result.fields[tonumber(idx) + 1])
    end
    vim.lsp.buf_request(
      ctx.bufnr,
      "java/generateHashCodeEquals",
      { context = params, fields = fields },
      function(e, edit)
        if e then
          print("Could not execute java/generateHashCodeEquals: " .. e.message)
        end
        if edit then
          vim.lsp.util.apply_workspace_edit(edit, "utf-16")
        end
      end
    )
  end)
end

local function java_action_organize_imports(_, ctx)
  vim.lsp.buf_request(0, "java/organizeImports", ctx.params, function(err, resp)
    if err then
      print("Error on organize imports: " .. err.message)
      return
    end
    if resp then
      vim.lsp.util.apply_workspace_edit(resp, "utf-16")
    end
  end)
end

local function java_choose_imports(resp)
  local uri = resp[1]
  local selections = resp[2]
  local choices = {}
  for _, selection in ipairs(selections) do
    local start = selection.range.start

    local buf = vim.uri_to_bufnr(uri)
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_win_set_cursor(0, { start.line + 1, start.character })
    vim.api.nvim_command "normal! zvzz"
    vim.api.nvim_buf_add_highlight(
      0,
      highlight_ns,
      "IncSearch",
      start.line,
      start.character,
      selection.range["end"].character
    )
    vim.api.nvim_command "redraw"
    local candidates = selection.candidates
    local fqn = candidates[1].fullyQualifiedName
    local type_name = fqn:sub(find_last(fqn, "%.") + 1)
    local choice
    if #candidates == 1 then
      choice = candidates[1]
    elseif #candidates > 1 then
      local lines = {}
      for _, x in pairs(candidates) do
        table.insert(lines, x.fullyQualifiedName)
      end
      local idx = vim.fn["quickui#listbox#inputlist"](lines, {
        index = -1,
        title = "Choose type " .. type_name .. " to import",
      })
      choice = candidates[idx + 1]
    end

    vim.api.nvim_buf_clear_namespace(0, highlight_ns, 0, -1)
    table.insert(choices, choice)
  end
  return choices
end

M.commands = {
  ["java.action.generateToStringPrompt"] = java_generate_to_string_prompt,
  ["java.action.hashCodeEqualsPrompt"] = java_hash_code_equals_prompt,
  ["java.action.organizeImports"] = java_action_organize_imports,
  ["java.action.organizeImports.chooseImports"] = java_choose_imports,
  ["java.action.generateConstructorsPrompt"] = java_generate_constructors_prompt,
  ["java.action.generateDelegateMethodsPrompt"] = java_generate_delegate_methods_prompt,
}

local function make_code_action_params(from_selection)
  local params
  if from_selection then
    params = vim.lsp.util.make_given_range_params()
  else
    params = vim.lsp.util.make_range_params()
  end
  local bufnr = vim.api.nvim_get_current_buf()
  params.context = {
    diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr),
  }
  return params
end

function M.organize_imports()
  java_action_organize_imports(nil, { params = make_code_action_params(false) })
end

function M.setup()
  if vim.lsp.commands then
    for k, v in pairs(M.commands) do
      vim.lsp.commands[k] = v
    end
  end
  if not vim.lsp.handlers["workspace/executeClientCommand"] then
    vim.lsp.handlers["workspace/executeClientCommand"] = function(_, params, ctx)
      local fn = M.commands[params.command]
      if fn then
        local ok, result = pcall(fn, params.arguments, ctx)
        if ok then
          return result
        else
          return vim.lsp.rpc_response_error(vim.lsp.protocol.ErrorCodes.InternalError, result)
        end
      else
        return vim.lsp.rpc_response_error(
          vim.lsp.protocol.ErrorCodes.MethodNotFound,
          "Command " .. params.command .. " not supported on client"
        )
      end
    end
  end
end

return M
