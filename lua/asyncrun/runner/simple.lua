local M = {}

local function is_true(value)
  return value == true or value == 1 or value == "1"
end

function M.runner(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local cwd = opts.cwd
  if not cwd or cwd == "" then
    cwd = vim.fn.getcwd()
  end

  local terminal = Terminal:new({
    cmd = opts.cmd,
    dir = cwd,
    direction = "horizontal",
    hidden = true,
    close_on_exit = false,
  })

  if is_true(opts.silent) then
    terminal:spawn()
  else
    terminal:open()
  end
end

return M
