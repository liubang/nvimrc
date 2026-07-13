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
              end,
              open = function()
                calls.open = true
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
end)
