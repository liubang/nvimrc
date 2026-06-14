local M = {}

function M.runner(opts)
  local cwd = opts.cwd or vim.fn.getcwd()
  local cmd = string.format("cd '%s' && %s\n", cwd, opts.cmd)

  local function send()
    local term = require("toggleterm.terminal")
    local id = term.get_focused_id()
    if not id then
      return
    end
    local t = term.get(id)
    if t and t.job_id then
      vim.api.nvim_chan_send(t.job_id, cmd)
    end
  end

  if not opts.silent then
    vim.cmd("ToggleTerm direction=horizontal")
    vim.cmd("startinsert")
    vim.defer_fn(send, 200)
  end
end

return M
