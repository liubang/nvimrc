local M = {}

local function is_true(value)
  return value == true or value == 1 or value == "1"
end

local function start_failed(err)
  vim.g.asyncrun_code = -1
  vim.g.asyncrun_status = "failure"
  error(err, 0)
end

function M.runner(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local cwd = opts.cwd
  if not cwd or cwd == "" then
    cwd = vim.fn.getcwd()
  end

  local ok, terminal = pcall(Terminal.new, Terminal, {
    cmd = opts.cmd,
    dir = cwd,
    direction = "horizontal",
    hidden = true,
    close_on_exit = is_true(opts.close),
    on_exit = function(_term, _job_id, exit_code, _event_name)
      vim.g.asyncrun_code = exit_code
      vim.g.asyncrun_status = exit_code == 0 and "success" or "failure"
      if opts.post and opts.post ~= "" then
        local ok, err = pcall(vim.cmd, opts.post)
        if not ok then
          vim.notify("AsyncRun: " .. tostring(err), vim.log.levels.ERROR)
        end
      end
      vim.cmd("doautocmd User AsyncRunStop")
    end,
  })
  if not ok then
    start_failed(terminal)
  end

  local started, err
  if is_true(opts.silent) then
    started, err = pcall(terminal.spawn, terminal)
  else
    started, err = pcall(terminal.open, terminal)
  end
  if not started then
    start_failed(err)
  end
  vim.g.asyncrun_status = "running"
end

return M
