local ROOT = vim.fn.getcwd()

local function make_buffer(filetype, lines)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  vim.bo[buf].filetype = filetype
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  return buf
end

local function wipe_buffer(buf)
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

local function count_exact_line(lines, expected)
  local count = 0
  for _, line in ipairs(lines) do
    if line == expected then
      count = count + 1
    end
  end
  return count
end

local function find_created(lines)
  for _, line in ipairs(lines) do
    if line:find("Created:", 1, true) then
      return line
    end
  end
end

local function save_keymap(mode, lhs)
  return vim.fn.maparg(lhs, mode, false, true)
end

local function restore_keymap(mode, lhs, saved)
  if saved and saved.lhs then
    vim.fn.mapset(mode, false, saved)
  else
    pcall(vim.keymap.del, mode, lhs)
  end
end

local function with_getchar(keys, fn)
  local original = vim.fn.getchar
  local index = 0
  vim.fn.getchar = function()
    index = index + 1
    return keys[index] or "\27"
  end
  local ok, result = pcall(fn)
  vim.fn.getchar = original
  if not ok then
    error(result, 0)
  end
  return result
end

local function has_value(values, expected)
  for _, value in ipairs(values) do
    if value == expected then
      return true
    end
  end
  return false
end

describe("core compatibility regressions", function()
  it("preserves shada values and appends both ignored directories", function()
    local original = vim.o.shada
    vim.o.shada = "!,'77,<88"
    local ok, err = pcall(dofile, ROOT .. "/lua/venux/options.lua")
    local actual = vim.o.shada
    vim.o.shada = original
    if not ok then
      error(err, 0)
    end

    assert.is_true(actual:find("!,'77,<88", 1, true) == 1)
    assert.is_not_nil(actual:find("r/tmp/", 1, true))
    assert.is_not_nil(actual:find("r/private/", 1, true))
  end)

  it("uses buf-local autocmd/keymap options and vim.hl for yank highlights", function()
    local original_on_yank = vim.hl.on_yank
    local yank_called = false
    local buf
    vim.hl.on_yank = function()
      yank_called = true
    end

    local ok, err = pcall(function()
      dofile(ROOT .. "/lua/venux/autocmd.lua")
      buf = make_buffer("help", { "help" })
      vim.api.nvim_exec_autocmds("FileType", { pattern = "help" })
      vim.wait(200, function()
        local map = vim.fn.maparg("q", "n", false, true)
        return map.buffer == 1 and map.desc == "Quit buffer"
      end)
      vim.api.nvim_exec_autocmds("BufNewFile", { pattern = "core-regression" })
      local writes = vim.api.nvim_get_autocmds({ event = "BufWritePre", buffer = buf })
      assert.are.same(1, #writes)
      vim.api.nvim_exec_autocmds("TextYankPost", {})
    end)
    local map = vim.fn.maparg("q", "n", false, true)
    vim.hl.on_yank = original_on_yank
    wipe_buffer(buf)
    if not ok then
      error(err, 0)
    end

    assert.are.same(1, map.buffer)
    assert.are.same("Quit buffer", map.desc)
    assert.is_true(yank_called)
  end)
end)

describe("file header regressions", function()
  local comment = require("venux.utils.comment")

  it("keeps one PHP prologue across insertion and existing-header updates", function()
    local buf = make_buffer("php", { "<?php", "echo 'ok';" })
    local ok, err = pcall(function()
      comment.copy_right_apache()
      local created = find_created(vim.api.nvim_buf_get_lines(buf, 0, -1, true))
      comment.add_fileheader()
      comment.copy_right_apache()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true)

      assert.are.same("<?php", lines[1])
      assert.are.same(1, count_exact_line(lines, "<?php"))
      assert.are.same(created, find_created(lines))
      assert.are.same("echo 'ok';", lines[#lines])
      assert.is_true(lines[2]:find("Copyright %(c%)") ~= nil)
    end)
    wipe_buffer(buf)
    if not ok then
      error(err, 0)
    end
  end)

  it("preserves a Python shebang and second-line encoding declaration", function()
    local prologue = { "#!/usr/bin/env python3", "# -*- coding: gb18030 -*-" }
    local buf = make_buffer("python", { prologue[1], prologue[2], "print('ok')" })
    local ok, err = pcall(function()
      comment.copy_right_apache()
      comment.add_fileheader()
      comment.copy_right_apache()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true)

      assert.are.same(prologue, { lines[1], lines[2] })
      assert.are.same(1, count_exact_line(lines, prologue[1]))
      assert.are.same(1, count_exact_line(lines, prologue[2]))
      assert.are.same("print('ok')", lines[#lines])
      assert.is_true(lines[3]:find("Copyright %(c%)") ~= nil)
    end)
    wipe_buffer(buf)
    if not ok then
      error(err, 0)
    end
  end)
end)

describe("utility regressions", function()
  local util = require("venux.utils.util")

  it("restores a clamped cursor row and byte column after trimming EOF", function()
    local buf = make_buffer("lua", { "alpha", "beta   ", "", string.rep(" ", 20) })
    local ok, err = pcall(function()
      vim.api.nvim_win_set_cursor(0, { 4, 10 })
      util.trim_whitespace()

      assert.are.same({ "alpha", "beta" }, vim.api.nvim_buf_get_lines(buf, 0, -1, true))
      assert.are.same({ 2, 3 }, vim.api.nvim_win_get_cursor(0))
    end)
    wipe_buffer(buf)
    if not ok then
      error(err, 0)
    end
  end)

  it("delegates opening paths to vim.ui.open", function()
    local original = vim.ui.open
    local opened
    vim.ui.open = function(file)
      opened = file
    end
    local ok, err = pcall(util.open, "/tmp/a path")
    vim.ui.open = original
    if not ok then
      error(err, 0)
    end
    assert.are.same("/tmp/a path", opened)
  end)

  it("uses sh on Unix and COMSPEC with /c on Windows", function()
    local original_system = vim.system
    local original_comspec = vim.env.COMSPEC
    local original_is_win = util.is_win
    local commands = {}
    vim.system = function(cmd, _)
      commands[#commands + 1] = cmd
      return {
        wait = function()
          return { code = 0, stdout = "ok\n" }
        end,
      }
    end

    local ok, err = pcall(function()
      util.is_win = false
      assert.are.same({ "ok" }, util.shell("printf ok"))
      util.is_win = true
      vim.env.COMSPEC = [[C:\Windows\System32\cmd.exe]]
      assert.are.same({ "ok" }, util.shell("echo ok"))
    end)
    util.is_win = original_is_win
    vim.env.COMSPEC = original_comspec
    vim.system = original_system
    if not ok then
      error(err, 0)
    end

    assert.are.same({ "sh", "-c", "printf ok" }, commands[1])
    assert.are.same({ [[C:\Windows\System32\cmd.exe]], "/c", "echo ok" }, commands[2])
  end)
end)

describe("TLA installation regressions", function()
  local tla = require("venux.utils.tla")
  local original_system, original_schedule_wrap, original_notify, original_mkdir, original_jar
  local jar, commands, download_code, download_callbacks, defer_download

  before_each(function()
    original_system = vim.system
    original_schedule_wrap = vim.schedule_wrap
    original_notify = vim.notify
    original_mkdir = vim.fn.mkdir
    original_jar = vim.g.tla2tools_path
    jar = vim.fn.tempname() .. ".jar"
    commands = {}
    download_callbacks = {}
    defer_download = false
    download_code = 0
    vim.g.tla2tools_path = jar
    vim.fn.writefile({ "old" }, jar)
    vim.fn.mkdir = function()
      return 1
    end
    vim.notify = function() end
    vim.schedule_wrap = function(fn)
      return fn
    end
    vim.system = function(cmd, _, callback)
      commands[#commands + 1] = cmd
      if not has_value(cmd, "-o") then
        callback({
          code = 0,
          stdout = vim.json.encode({
            tag_name = "test",
            assets = {
              { name = "tla2tools.jar", browser_download_url = "https://example.test/tla2tools.jar" },
            },
          }),
        })
        return
      end

      local output
      for i, value in ipairs(cmd) do
        if value == "-o" then
          output = cmd[i + 1]
          break
        end
      end
      assert.is_not_nil(output)
      local function finish_download()
        vim.fn.writefile({ download_code == 0 and "new" or "partial" }, output)
        callback({ code = download_code })
      end
      if defer_download then
        download_callbacks[#download_callbacks + 1] = finish_download
      else
        finish_download()
      end
    end
  end)

  after_each(function()
    vim.system = original_system
    vim.schedule_wrap = original_schedule_wrap
    vim.notify = original_notify
    vim.fn.mkdir = original_mkdir
    vim.g.tla2tools_path = original_jar
    vim.uv.fs_unlink(jar)
    for _, path in ipairs(vim.fn.glob(jar .. ".tmp.*", false, true)) do
      vim.uv.fs_unlink(path)
    end
  end)

  it("uses curl -f and renames a complete temporary download", function()
    tla.install()

    assert.are.same(2, #commands)
    assert.is_true(has_value(commands[1], "-f"))
    assert.is_true(has_value(commands[2], "-f"))
    local tmp = commands[2][5]
    local prefix = jar .. ".tmp."
    assert.are.same(prefix, tmp:sub(1, #prefix))
    assert.are.same(#prefix + 6, #tmp)
    assert.are.same({ "new" }, vim.fn.readfile(jar))
    assert.is_nil(vim.uv.fs_stat(tmp))
  end)

  it("keeps the existing jar and removes a failed partial download", function()
    download_code = 22
    tla.install()

    assert.are.same({ "old" }, vim.fn.readfile(jar))
    assert.are.same("", vim.fn.glob(jar .. ".tmp.*"))
  end)

  it("isolates overlapping downloads and preserves the successful result", function()
    defer_download = true
    tla.install()
    tla.install()

    assert.are.same(4, #commands)
    assert.are.same(2, #download_callbacks)
    local first_tmp, second_tmp = commands[2][5], commands[4][5]
    assert.are_not.same(first_tmp, second_tmp)

    download_code = 22
    download_callbacks[1]()
    download_code = 0
    download_callbacks[2]()

    assert.are.same({ "new" }, vim.fn.readfile(jar))
    assert.is_nil(vim.uv.fs_stat(first_tmp))
    assert.is_nil(vim.uv.fs_stat(second_tmp))
  end)
end)

describe("mapping state regressions", function()
  it("resets both acceleration step and previous timestamp", function()
    local accelerated = require("venux.utils.accelerated_jk")
    local saved_j = save_keymap("n", "j")
    local saved_k = save_keymap("n", "k")
    local ok, err = pcall(function()
      accelerated.setup({ acceleration_limit = 150, acceleration_table = { 2, 4 } })
      local callback = vim.fn.maparg("j", "n", false, true).callback
      assert.is_not_nil(callback)
      local upvalue, accel = debug.getupvalue(callback, 1)
      assert.are.same("accel", upvalue)
      assert.are.same(1, accel.advance(1000))
      assert.are.same(2, accel.advance(1010))
      accel.reset()
      assert.are.same(1, accel.advance(1020))
    end)
    restore_keymap("n", "j", saved_j)
    restore_keymap("n", "k", saved_k)
    if not ok then
      error(err, 0)
    end
  end)

  it("replaces a builtin item with a user mapping for the same key", function()
    local original_snacks = rawget(_G, "Snacks")
    local saved_j = save_keymap("n", "j")
    local items
    Snacks = {
      picker = function(opts)
        items = opts.finder()
      end,
    }

    local ok, err = pcall(function()
      vim.keymap.set("n", "j", "<Down>", { desc = "User down" })
      require("venux.utils.keyfinder").open()
    end)
    Snacks = original_snacks
    restore_keymap("n", "j", saved_j)
    if not ok then
      error(err, 0)
    end

    local matches = {}
    for _, item in ipairs(items) do
      if item.mode == "n" and item.lhs == "j" then
        matches[#matches + 1] = item
      end
    end
    assert.are.same(1, #matches)
    assert.are.same("key", matches[1].kind)
    assert.are.same("User down", matches[1].desc)
  end)
end)

describe("headless UI regressions", function()
  it("uses screen coordinates for cursor and center menus", function()
    local lines = {}
    for i = 1, 100 do
      lines[i] = "前缀é " .. i
    end
    local buf = make_buffer("lua", lines)
    vim.api.nvim_win_set_cursor(0, { 60, 4 })
    local original_getchar = vim.fn.getchar
    local original_open_win = vim.api.nvim_open_win
    local configs = {}
    vim.fn.getchar = function()
      return "\27"
    end
    vim.api.nvim_open_win = function(float_buf, enter, config)
      configs[#configs + 1] = config
      return original_open_win(float_buf, enter, config)
    end

    local ok, err = pcall(function()
      require("venux.ui.context_menu").open({ "&Open" }, { position = "cursor" })
      require("venux.ui.context_menu").open({ "&Open" }, { position = "center" })
    end)
    vim.fn.getchar = original_getchar
    vim.api.nvim_open_win = original_open_win
    wipe_buffer(buf)
    if not ok then
      error(err, 0)
    end

    assert.are.same("editor", configs[1].relative)
    assert.is_number(configs[1].row)
    assert.is_number(configs[1].col)
    assert.are.same("editor", configs[2].relative)
  end)

  it("keeps cursor menus and their borders inside the editor at the bottom right", function()
    local lines = {}
    for i = 1, 100 do
      lines[i] = "line " .. i .. " " .. string.rep("宽", 30)
    end
    local buf = make_buffer("lua", lines)
    vim.api.nvim_win_set_cursor(0, { 100, #lines[100] - 1 })
    local items = {}
    for i = 1, 30 do
      items[i] = "item " .. i .. " " .. string.rep("wide", 20)
    end

    local original_open_win = vim.api.nvim_open_win
    local snapshot
    vim.api.nvim_open_win = function(float_buf, enter, config)
      local win = original_open_win(float_buf, enter, config)
      snapshot = {
        position = vim.api.nvim_win_get_position(win),
        width = config.width,
        height = config.height,
      }
      return win
    end

    local ok, err = pcall(function()
      with_getchar({ "\27" }, function()
        require("venux.ui.context_menu").open(items, { position = "cursor" })
      end)
    end)
    vim.api.nvim_open_win = original_open_win
    wipe_buffer(buf)
    if not ok then
      error(err, 0)
    end

    assert.is_not_nil(snapshot)
    assert.is_true(snapshot.position[1] >= 0)
    assert.is_true(snapshot.position[2] >= 0)
    assert.is_true(snapshot.position[1] + snapshot.height + 2 <= vim.o.lines)
    assert.is_true(snapshot.position[2] + snapshot.width + 2 <= vim.o.columns)
  end)

  it("deletes a whole UTF-8 word backward with Ctrl-W", function()
    local result = with_getchar({ "\23", "\r" }, function()
      return require("venux.ui.inputbox").open("Input", { text = "é abc" })
    end)
    assert.are.same("é ", result)
  end)

  it("does not insert unhandled special keys beginning with 0x80", function()
    local result = with_getchar({ "\x80kX", "\r" }, function()
      return require("venux.ui.inputbox").open("Input", { text = "abc" })
    end)
    assert.are.same("abc", result)
  end)

  it("disables cursorline for cursor=-1 and honors index as topline", function()
    local lines = {}
    for i = 1, 100 do
      lines[i] = "line " .. i
    end
    local original = vim.fn.getchar
    local snapshots = {}
    vim.fn.getchar = function()
      snapshots[#snapshots + 1] = {
        topline = vim.fn.line("w0"),
        cursorline = vim.wo[0].cursorline,
        cursor = vim.api.nvim_win_get_cursor(0)[1],
      }
      return "q"
    end

    local ok, err = pcall(function()
      require("venux.ui.textbox").open(lines, { index = 40, cursor = -1, h = 10, wrap = false })
      require("venux.ui.textbox").open(lines, { index = 2, cursor = 3, h = 10, wrap = false })
    end)
    vim.fn.getchar = original
    if not ok then
      error(err, 0)
    end

    assert.are.same(40, snapshots[1].topline)
    assert.are.same(40, snapshots[1].cursor)
    assert.is_false(snapshots[1].cursorline)
    assert.is_true(snapshots[2].cursorline)
    assert.are.same(3, snapshots[2].cursor)
  end)
end)
