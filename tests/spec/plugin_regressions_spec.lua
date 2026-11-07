local function load_spec(path)
  return dofile(vim.fn.getcwd() .. "/" .. path)
end

local function find_plugin(specs, name)
  for _, spec in ipairs(specs) do
    if spec[1] == name then
      return spec
    end
  end
  error("Plugin not found: " .. name)
end

local function with_modules(modules, fn)
  local previous = {}
  for name, module in pairs(modules) do
    previous[name] = package.loaded[name]
    package.loaded[name] = module
  end
  local ok, err = pcall(fn)
  for name in pairs(modules) do
    package.loaded[name] = previous[name]
  end
  if not ok then
    error(err)
  end
end

describe("plugin regressions", function()
  it("uses supported lazy-loading triggers and option keys", function()
    local blink = load_spec("lua/plugins/blink.lua")
    assert.are.same({ "BufReadPre", "InsertEnter", "CmdlineEnter" }, blink.event)

    local vimtex = load_spec("lua/plugins/vimtex.lua")[1]
    assert.is_false(vimtex.lazy)
    assert.is_nil(vimtex.ft)

    local toggleterm = load_spec("lua/plugins/toggleterm.lua")
    assert.are.same({ "ToggleTerm", "TermExec", "TermSelect" }, toggleterm.cmd)

    local folio = load_spec("lua/plugins/markdown.lua")
    assert.is_true(vim.tbl_contains(folio.cmd, "FolioCloseAll"))

    local grug = load_spec("lua/plugins/grug-far.lua")
    assert.is_nil(grug.opts)

    local outline = load_spec("lua/plugins/outline.lua")
    assert.are.same({ position = "right", width = 25 }, outline.opts.outline_window)
    assert.is_nil(outline.opts.position)
    assert.is_nil(outline.opts.width)

    local venn = load_spec("lua/plugins/venn-nvim.lua")
    assert.are.same("DrawBoxToggle", venn.cmd)
    assert.is_nil(venn.init)
  end)

  it("uses only gruvbox-material configuration variables", function()
    local gruvbox = find_plugin(load_spec("lua/plugins/colorscheme.lua"), "sainnhe/gruvbox-material")
    local names = {
      "gruvbox_material_transparent_background",
      "gruvbox_transp_bg",
      "gruvbox_filetype_hi_groups",
      "gruvbox_plugin_hi_groups",
    }
    local previous = {}
    for _, name in ipairs(names) do
      previous[name] = vim.g[name]
      vim.g[name] = nil
    end

    local original_colorscheme = vim.cmd.colorscheme
    vim.cmd.colorscheme = function() end
    local ok, err = pcall(gruvbox.config)
    vim.cmd.colorscheme = original_colorscheme

    local values = {}
    for _, name in ipairs(names) do
      values[name] = vim.g[name]
      vim.g[name] = previous[name]
    end
    pcall(vim.api.nvim_del_user_command, "Gruvbox")
    if not ok then
      error(err)
    end

    assert.are.same(1, values.gruvbox_material_transparent_background)
    assert.is_nil(values.gruvbox_transp_bg)
    assert.is_nil(values.gruvbox_filetype_hi_groups)
    assert.is_nil(values.gruvbox_plugin_hi_groups)
  end)

  it("keeps the default gitignore filetype detection", function()
    load_spec("after/ftdetect/init.lua")
    assert.are_not.same("gitconfig", vim.filetype.match({ filename = ".gitignore" }))
  end)

  it("checks the lua-language-server executable", function()
    local original_health = vim.health
    local original_executable = vim.fn.executable
    local checked = {}
    vim.health = { start = function() end, ok = function() end, warn = function() end, error = function() end }
    vim.fn.executable = function(bin)
      checked[bin] = true
      return 1
    end
    local ok, err = pcall(function()
      load_spec("lua/venux/health.lua").check()
    end)
    vim.health = original_health
    vim.fn.executable = original_executable
    if not ok then
      error(err)
    end
    assert.is_true(checked["lua-language-server"])
    assert.is_nil(checked.lua_ls)
  end)

  it("uses the standard Mason registry and leaves jdtls to nvim-java", function()
    local lsp = load_spec("lua/plugins/lsp/init.lua")
    local mason = find_plugin(lsp, "mason-org/mason.nvim")
    assert.are.same({ "github:mason-org/mason-registry" }, mason.opts.registries)

    local setup_opts
    with_modules({
      ["mason-lspconfig"] = {
        setup = function(opts)
          setup_opts = opts
        end,
      },
      ["plugins.lsp.config"] = { setup = function() end },
      ["plugins.lsp.servers"] = { setup = function() end },
    }, function()
      find_plugin(lsp, "neovim/nvim-lspconfig").config()
    end)
    assert.are.same({ "clangd", "gopls", "lua_ls" }, setup_opts.ensure_installed)
  end)

  it("starts LemMinX exclusively from its uber jar", function()
    local lemminx
    with_modules({ ["plugins.java.utils"] = { java_bin = "java" } }, function()
      lemminx = load_spec("lua/plugins/lsp/servers/lemminx.lua")
    end)
    assert.are.same(3, #lemminx.cmd)
    assert.are.same("java", lemminx.cmd[1])
    assert.are.same("-jar", lemminx.cmd[2])
    assert.is_truthy(lemminx.cmd[3]:match("/lemminx/org%.eclipse%.lemminx%-uber%.jar$"))
  end)

  it("reapplies Snacks dashboard highlights after ColorScheme", function()
    local snacks = {
      setup = function() end,
      picker = { select = function() end },
    }
    local original_select = vim.ui.select
    with_modules({ snacks = snacks }, function()
      local spec = load_spec("lua/plugins/snacks.lua")
      spec.config(nil, {})
      vim.api.nvim_set_hl(0, "SnacksDashboardHeader", {})
      vim.api.nvim_set_hl(0, "SnacksDashboardKey", {})
      vim.api.nvim_exec_autocmds("ColorScheme", { pattern = "Regression" })

      local header = vim.api.nvim_get_hl(0, { name = "SnacksDashboardHeader", link = true })
      local key = vim.api.nvim_get_hl(0, { name = "SnacksDashboardKey", link = true })
      assert.are.same("Keyword", header.link)
      assert.are.same("Identifier", key.link)

      spec.config(nil, {})
      local autocmds = vim.api.nvim_get_autocmds({
        group = "VenuxSnacksDashboardHighlights",
        event = "ColorScheme",
      })
      assert.are.same(1, #autocmds)
    end)
    vim.ui.select = original_select
  end)

  it("does not accumulate mini.files write handlers", function()
    local synchronize_calls = 0
    local mini_files = {
      setup = function() end,
      synchronize = function()
        synchronize_calls = synchronize_calls + 1
      end,
    }

    with_modules({ ["mini.files"] = mini_files }, function()
      local spec = find_plugin(load_spec("lua/plugins/mini.lua"), "nvim-mini/mini.files")
      spec.config(nil, {})
      local buf = vim.api.nvim_create_buf(false, true)
      local function fire(pattern)
        vim.api.nvim_exec_autocmds("User", {
          pattern = pattern,
          data = { buf_id = buf },
        })
      end
      local function write_handlers()
        return vim.api.nvim_get_autocmds({ event = "BufWriteCmd", buffer = buf })
      end

      fire("MiniFilesBufferCreate")
      assert.is_true(vim.wait(1000, function()
        return #write_handlers() == 1
      end))
      for _ = 1, 3 do
        fire("MiniFilesBufferUpdate")
        fire("MiniFilesBufferCreate")
      end
      vim.wait(20)

      assert.are.same(1, #write_handlers())
      assert.are.same("acwrite", vim.bo[buf].buftype)
      local has_split_map = vim.api.nvim_buf_call(buf, function()
        return vim.fn.maparg("<C-s>", "n", false, true).buffer == 1
      end)
      assert.is_true(has_split_map)
      assert.are.same(0, #vim.api.nvim_get_autocmds({
        event = "User",
        pattern = "MiniFilesActionRename",
      }))

      vim.api.nvim_exec_autocmds("BufWriteCmd", { buffer = buf })
      assert.are.same(1, synchronize_calls)
      vim.api.nvim_buf_delete(buf, { force = true })
    end)
  end)

  it("restores virtualedit and existing buffer-local maps after Venn toggles", function()
    local venn = { set_line = function() end, set_arrow = function() end }
    with_modules({ venn = venn }, function()
      local spec = load_spec("lua/plugins/venn-nvim.lua")
      spec.config()
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(buf)
      vim.opt_local.virtualedit = "block"

      local original_h = function() end
      vim.keymap.set("n", "H", original_h, { buffer = buf, desc = "Original H" })
      vim.keymap.set("x", "f", ":echo 'original f'<CR>", { buffer = buf, nowait = true })

      for _ = 1, 2 do
        vim.cmd("DrawBoxToggle")
        assert.is_true(vim.b[buf].venn_enabled)
        assert.are.same("all", vim.wo.virtualedit)
        assert.is_truthy(vim.fn.maparg("H", "n", false, true).rhs:match("VBox"))

        vim.cmd("DrawBoxToggle")
        assert.is_nil(vim.b[buf].venn_enabled)
        assert.are.same("block", vim.wo.virtualedit)
        local h = vim.fn.maparg("H", "n", false, true)
        assert.are.same(1, h.buffer)
        assert.is_true(h.callback == original_h)
        assert.are.same("Original H", h.desc)
        local f = vim.fn.maparg("f", "x", false, true)
        assert.are.same(":echo 'original f'<CR>", f.rhs)
        assert.are.same(1, f.nowait)
        assert.is_nil(vim.fn.maparg("K", "n", false, true).buffer)
      end

      vim.keymap.del("n", "H", { buffer = buf })
      vim.keymap.del("x", "f", { buffer = buf })
      vim.opt_local.virtualedit = ""
      vim.api.nvim_buf_delete(buf, { force = true })
    end)
  end)

  it("restores Venn virtualedit in the window where it was enabled", function()
    local venn = { set_line = function() end, set_arrow = function() end }
    with_modules({ venn = venn }, function()
      local spec = load_spec("lua/plugins/venn-nvim.lua")
      spec.config()
      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(buf)
      local first = vim.api.nvim_get_current_win()
      vim.opt_local.virtualedit = "block"

      vim.cmd("DrawBoxToggle")
      local second = vim.api.nvim_open_win(buf, true, { split = "right" })
      assert.are.same("all", vim.wo[second].virtualedit)
      vim.cmd("DrawBoxToggle")

      assert.are.same("block", vim.wo[first].virtualedit)
      assert.are.same("block", vim.wo[second].virtualedit)
      assert.is_nil(vim.b[buf].venn_enabled)

      vim.api.nvim_win_close(second, true)
      vim.api.nvim_buf_delete(buf, { force = true })
    end)
  end)
end)
