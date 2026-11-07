describe("asyncrun simple runner", function()
  local calls

  before_each(function()
    calls = {}
    package.loaded["asyncrun.runner.simple"] = nil
    package.loaded["toggleterm.terminal"] = nil
    package.preload["toggleterm.terminal"] = function()
      return {
        Terminal = {
          new = function(_, opts)
            calls.opts = opts
            return {
              spawn = function()
                calls.spawn = true
                if calls.spawn_error then
                  error(calls.spawn_error)
                end
              end,
              open = function()
                calls.open = true
                if calls.open_error then
                  error(calls.open_error)
                end
              end,
            }
          end,
        },
      }
    end
  end)

  after_each(function()
    package.loaded["asyncrun.runner.simple"] = nil
    package.loaded["toggleterm.terminal"] = nil
    package.preload["toggleterm.terminal"] = nil
    pcall(vim.api.nvim_del_augroup_by_name, "AsyncRunSimpleRunnerSpec")
    vim.g.asyncrun_code = nil
    vim.g.asyncrun_status = nil
    vim.g.asyncrun_simple_post_calls = nil
  end)

  it("spawns silent tasks without opening a window", function()
    require("asyncrun.runner.simple").runner({ cmd = "printf ok", cwd = "/tmp", silent = 1 })

    assert.is_true(calls.spawn)
    assert.is_nil(calls.open)
    assert.are.same("printf ok", calls.opts.cmd)
    assert.are.same("/tmp", calls.opts.dir)
    assert.is_false(calls.opts.close_on_exit)
  end)

  it("opens visible tasks and falls back to the current directory", function()
    require("asyncrun.runner.simple").runner({ cmd = "printf ok", cwd = "", silent = 0 })

    assert.is_true(calls.open)
    assert.is_nil(calls.spawn)
    assert.are.same(vim.fn.getcwd(), calls.opts.dir)
  end)

  it("does not leave a running status when startup fails", function()
    calls.spawn_error = "invalid working directory"

    local ok, err = pcall(require("asyncrun.runner.simple").runner, {
      cmd = "printf ok",
      cwd = "/missing",
      silent = 1,
    })

    assert.is_false(ok)
    assert.is_truthy(tostring(err):match("invalid working directory"))
    assert.are.same(-1, vim.g.asyncrun_code)
    assert.are.same("failure", vim.g.asyncrun_status)
  end)

  it("finishes asyncrun state, events, and post once on exit", function()
    local stop_calls = 0
    local code_at_stop
    local status_at_stop
    local post_at_stop
    local group = vim.api.nvim_create_augroup("AsyncRunSimpleRunnerSpec", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "AsyncRunStop",
      callback = function()
        stop_calls = stop_calls + 1
        code_at_stop = vim.g.asyncrun_code
        status_at_stop = vim.g.asyncrun_status
        post_at_stop = vim.g.asyncrun_simple_post_calls
      end,
    })
    vim.g.asyncrun_simple_post_calls = 0

    require("asyncrun.runner.simple").runner({
      cmd = "printf ok",
      cwd = "/tmp",
      silent = 1,
      close = "1",
      post = "let g:asyncrun_simple_post_calls = get(g:, 'asyncrun_simple_post_calls', 0) + 1",
    })

    assert.is_true(calls.opts.close_on_exit)
    assert.is_function(calls.opts.on_exit)
    assert.are.same("running", vim.g.asyncrun_status)
    calls.opts.on_exit({}, 17, 23, "exit")

    assert.are.same(23, vim.g.asyncrun_code)
    assert.are.same("failure", vim.g.asyncrun_status)
    assert.are.same(23, code_at_stop)
    assert.are.same("failure", status_at_stop)
    assert.are.same(1, post_at_stop)
    assert.are.same(1, stop_calls)
    assert.are.same(1, vim.g.asyncrun_simple_post_calls)
  end)

  it("fires AsyncRunStop after an invalid post without throwing", function()
    local stop_calls = 0
    local status_at_stop
    local group = vim.api.nvim_create_augroup("AsyncRunSimpleRunnerSpec", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "AsyncRunStop",
      callback = function()
        stop_calls = stop_calls + 1
        status_at_stop = vim.g.asyncrun_status
      end,
    })

    require("asyncrun.runner.simple").runner({
      cmd = "false",
      cwd = "/tmp",
      silent = 1,
      post = "throw 'invalid post'",
    })

    local original_notify = vim.notify
    local notifications = {}
    vim.notify = function(message)
      notifications[#notifications + 1] = message
    end
    local ok, err = pcall(calls.opts.on_exit, {}, 17, 1, "exit")
    vim.notify = original_notify

    assert.is_true(ok, err)
    assert.are.same(1, #notifications)
    assert.is_truthy(notifications[1]:match("invalid post"))
    assert.are.same(1, vim.g.asyncrun_code)
    assert.are.same("failure", vim.g.asyncrun_status)
    assert.are.same("failure", status_at_stop)
    assert.are.same(1, stop_calls)
  end)
end)
