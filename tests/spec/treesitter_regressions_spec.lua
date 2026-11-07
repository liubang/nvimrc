describe("treesitter regressions", function()
  local buffers
  local original_buffer
  local original_foldexpr
  local original_foldmethod
  local original_select

  local function new_buffer(lines)
    local buf = vim.api.nvim_create_buf(true, true)
    table.insert(buffers, buf)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines or { "local value = 1" })
    return buf
  end

  local function large_lines()
    local lines = {}
    for i = 1, 5001 do
      lines[i] = "line " .. i
    end
    return lines
  end

  local function display(buf)
    vim.cmd("buffer " .. buf)
  end

  before_each(function()
    buffers = {}
    original_buffer = vim.api.nvim_get_current_buf()
    original_foldmethod = vim.wo.foldmethod
    original_foldexpr = vim.wo.foldexpr
    original_select = vim.treesitter.select
    vim.g.mapleader = " "
    require("venux.treesitter").setup()
  end)

  after_each(function()
    vim.treesitter.select = original_select
    if vim.api.nvim_buf_is_valid(original_buffer) then
      vim.api.nvim_set_current_buf(original_buffer)
    end
    for _, buf in ipairs(buffers) do
      if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
    vim.wo.foldmethod = original_foldmethod
    vim.wo.foldexpr = original_foldexpr
  end)

  it("initializes folds when a background-loaded buffer is displayed", function()
    local buf = new_buffer()
    vim.bo[buf].filetype = "lua"
    vim.api.nvim_exec_autocmds("BufReadPost", { buffer = buf })
    assert.are.same({}, vim.fn.win_findbuf(buf))

    vim.wo.foldmethod = "manual"
    vim.wo.foldexpr = "0"
    display(buf)

    assert.are.same("expr", vim.wo.foldmethod)
    assert.are.same("v:lua.vim.treesitter.foldexpr()", vim.wo.foldexpr)
  end)

  it("uses indent folds for large files", function()
    local buf = new_buffer(large_lines())
    vim.bo[buf].filetype = "lua"

    display(buf)

    assert.are.same("indent", vim.wo.foldmethod)
    assert.are.same("", vim.wo.foldexpr)
  end)

  it("leaves folds managed by snacks.bigfile unchanged", function()
    local buf = new_buffer()
    vim.bo[buf].filetype = "bigfile"
    vim.wo.foldmethod = "manual"
    vim.wo.foldexpr = "0"

    display(buf)

    assert.are.same("manual", vim.wo.foldmethod)
    assert.are.same("0", vim.wo.foldexpr)
  end)

  it("delegates selection mappings to the built-in parent and child API", function()
    local calls = {}
    vim.treesitter.select = function(target, count)
      table.insert(calls, { target, count })
    end

    vim.fn.maparg("<Leader>i", "n", false, true).callback()
    vim.fn.maparg("<Leader>i", "x", false, true).callback()
    vim.fn.maparg("<Leader>I", "x", false, true).callback()

    assert.are.same({
      { "parent", 1 },
      { "parent", 1 },
      { "child", 1 },
    }, calls)
  end)

  it("keeps built-in parsers out of installation and disables automatic installs", function()
    local spec = dofile(vim.fn.getcwd() .. "/lua/plugins/treesitter.lua")

    assert.is_nil(spec.dependencies)
    assert.is_false(spec.opts.auto_install)
    assert.are.same({
      "go",
      "rust",
      "python",
      "java",
      "json",
      "proto",
      "gomod",
      "gosum",
      "gowork",
      "sql",
      "regex",
      "tlaplus",
    }, spec.opts.ensure_installed)
    assert.are.same(
      { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
      spec.opts.noauto_install
    )
  end)
end)
