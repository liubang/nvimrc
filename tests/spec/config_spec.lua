describe("configuration modules", function()
  it("loads self-contained modules", function()
    assert.is_table(require("snacks.bazel"))
    assert.is_table(require("snacks.tasks"))
    assert.is_table(require("venux.utils.fold"))
    assert.is_table(require("venux.utils.util"))
  end)

  it("keeps terminal output after commands exit", function()
    local spec = dofile(vim.fn.getcwd() .. "/lua/plugins/toggleterm.lua")
    assert.is_false(spec.opts.close_on_exit)
  end)

  it("only enables save formatting for selected filetypes", function()
    local spec = dofile(vim.fn.getcwd() .. "/lua/plugins/conform.lua")
    local lua_buf = vim.api.nvim_create_buf(false, true)
    local go_buf = vim.api.nvim_create_buf(false, true)
    local javascript_buf = vim.api.nvim_create_buf(false, true)
    vim.bo[lua_buf].filetype = "lua"
    vim.bo[go_buf].filetype = "go"
    vim.bo[javascript_buf].filetype = "javascript"

    local lua_opts = spec.opts.format_on_save(lua_buf)
    local go_opts = spec.opts.format_on_save(go_buf)

    assert.are.same(500, lua_opts.timeout_ms)
    assert.are.same("fallback", lua_opts.lsp_format)
    assert.are.same(1000, go_opts.timeout_ms)
    assert.are.same("fallback", go_opts.lsp_format)
    assert.are.same({ "goimports", "gofumpt", stop_after_first = false }, spec.opts.formatters_by_ft.go)
    assert.is_nil(spec.opts.format_on_save(javascript_buf))
    vim.api.nvim_buf_delete(lua_buf, { force = true })
    vim.api.nvim_buf_delete(go_buf, { force = true })
    vim.api.nvim_buf_delete(javascript_buf, { force = true })
  end)

  it("registers treesitter selection without shadowing visual block or venn", function()
    vim.g.mapleader = " "
    require("venux.treesitter").setup()

    assert.is_not_nil(vim.fn.maparg("<Leader>i", "n", false, true).callback)
    assert.is_not_nil(vim.fn.maparg("<Leader>i", "x", false, true).callback)
    assert.is_not_nil(vim.fn.maparg("<Leader>I", "x", false, true).callback)
    assert.are.same({}, vim.fn.maparg("<C-v>", "n", false, true))
    assert.are.same({}, vim.fn.maparg("<Leader>v", "n", false, true))

    local venn = dofile(vim.fn.getcwd() .. "/lua/plugins/venn-nvim.lua")
    assert.are.same("<leader>vv", venn.keys[1][1])
  end)
end)
