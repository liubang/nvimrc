--=====================================================================
--
-- runner.lua -
--
-- Created by liubang on 2022/09/21 21:56
-- Last Modified: 2022/09/21 21:56
--
--=====================================================================

local uv = vim.loop
local util = require "lb.utils.util"
local goutils = require "lb.go.utils"

local run = function(cmd, opts)
  opts = opts or {}
  if type(cmd) == "string" then
    local split_pattern = "%s+"
    cmd = vim.split(cmd, split_pattern)
  end
  local cmd_str = vim.inspect(cmd)
  local job_options = vim.deepcopy(opts or {})
  job_options.args = job_options.args or {}
  local cmdargs = vim.list_slice(cmd, 2, #cmd) or {}

  if cmdargs and cmdargs[1] == "test" and #cmdargs == 3 then
    table.insert(cmdargs, "." .. util.sep() .. "...")
  end
  vim.list_extend(cmdargs, job_options.args)
  job_options.args = cmdargs

  cmd = cmd[1]

  local stdin = uv.new_pipe(false)
  local stdout = uv.new_pipe(false)
  local stderr = uv.new_pipe(false)
  local handle = nil

  local output_buf = ""
  local output_stderr = ""
  local function update_chunk_fn(err, chunk)
    if err then
      vim.schedule(function()
        vim.notify("error " .. tostring(err) .. vim.inspect(chunk or ""), vim.log.levels.ERROR)
      end)
    end
    if chunk then
      output_buf = output_buf .. chunk
    end
  end
  local update_chunk = opts.update_chunk or update_chunk_fn

  handle, _ = uv.spawn(
    cmd,
    { stdio = { stdin, stdout, stderr }, args = job_options.args },
    function(code, signal) -- on exit
      -- stdin
      stdin:close()
      -- stdout
      stdout:read_stop()
      stdout:close()
      -- stderr
      stderr:read_stop()
      stderr:close()
      handle:close()

      if output_stderr ~= "" then
        vim.schedule(function()
          vim.notify(output_stderr, vim.log.levels.ERROR)
        end)
      end
      if opts and opts.on_exit then
        output_buf = opts.on_exit(code, signal, output_buf)
        if not output_buf then
          return
        end
      end
      if code ~= 0 then
        output_buf = output_buf or ""
        vim.notify(cmd_str .. " failed exit code " .. tostring(code) .. output_buf, vim.log.levels.WARN)
      end
      if output_buf ~= "" then
        local lines = vim.split(output_buf, "\n", true)
        lines = goutils.handle_job_data(lines)
        local locopts = {
          title = vim.inspect(cmd),
          lines = lines,
        }
        if opts.efm then
          locopts.efm = opts.efm
        end
        if #lines > 0 then
          vim.schedule(function()
            vim.fn.setloclist(0, {}, " ", locopts)
            vim.cmd "lopen"
          end)
        end
      end
    end
  )

  uv.read_start(stderr, function(err, data)
    if err then
      vim.notify("error " .. tostring(err) .. tostring(data or ""), vim.lsp.log_levels.WARN)
    end
    if data ~= nil then
      output_stderr = output_stderr .. tostring(data)
    end
  end)
  stdout:read_start(update_chunk)
  return stdin, stdout, stderr
end

return { run = run }
