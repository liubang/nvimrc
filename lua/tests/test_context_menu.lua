-- Test script for venux.ui.context_menu
-- Run with:  nvim -c "luafile lua/tests/test_context_menu.lua"

local context_menu = require("venux.ui.context_menu")

-- ── Test 1: Basic context menu with hotkeys, descriptions, separators ──
vim.keymap.set("n", "<leader>t1", function()
  local idx = context_menu.open({
    { "Open &File\tCtrl+O" },
    { "&Edit Buffer\tCtrl+E" },
    { "--" },
    { "&Save\tCtrl+S" },
    { "Save &All" },
    { "--" },
    { "&Quit\tCtrl+Q" },
  }, {
    title = " File Menu ",
  })
  vim.notify("Selected index: " .. idx, vim.log.levels.INFO)
end, { desc = "Test: basic context menu" })

-- ── Test 2: With callbacks ──
vim.keymap.set("n", "<leader>t2", function()
  context_menu.open({
    {
      "&New File",
      cmd = function()
        vim.notify("Creating new file...")
      end,
    },
    {
      "&Open File",
      cmd = function()
        vim.notify("Opening file...")
      end,
    },
    { "--" },
    {
      "Open &Recent",
      cmd = function()
        vim.notify("Opening recent...")
      end,
    },
    { "--" },
    {
      "&Settings",
      cmd = function()
        vim.notify("Opening settings...")
      end,
    },
    {
      "&Help\tF1",
      cmd = function()
        vim.notify("Opening help...")
      end,
    },
  }, {
    title = " Actions ",
  })
end, { desc = "Test: context menu with callbacks" })

-- ── Test 3: With disabled items ──
vim.keymap.set("n", "<leader>t3", function()
  context_menu.open({
    {
      "&Copy\tCtrl+C",
      cmd = function()
        vim.notify("Copy!")
      end,
    },
    {
      "Cu&t\tCtrl+X",
      cmd = function()
        vim.notify("Cut!")
      end,
    },
    {
      "&Paste\tCtrl+V",
      cmd = function()
        vim.notify("Paste!")
      end,
    },
    { "--" },
    { "&Undo\tCtrl+Z", enabled = false },
    { "&Redo\tCtrl+Y", enabled = false },
    { "--" },
    {
      "Select &All\tCtrl+A",
      cmd = function()
        vim.notify("Select all!")
      end,
    },
  }, {
    title = " Edit ",
  })
end, { desc = "Test: context menu with disabled items" })

-- ── Test 4: Centered position, no title ──
vim.keymap.set("n", "<leader>t4", function()
  context_menu.open({
    { "&Debug Start\tF5" },
    { "Step &Over\tF10" },
    { "Step &Into\tF11" },
    { "--" },
    { "&Breakpoint\tF9" },
    { "&Continue\tF5" },
    { "--" },
    { "&Stop\tShift+F5" },
  }, {
    position = "center",
    title = " Debug ",
  })
end, { desc = "Test: centered context menu" })

-- ── Test 5: Minimal, no descriptions ──
vim.keymap.set("n", "<leader>t5", function()
  context_menu.open({
    { "&Apple" },
    { "&Banana" },
    { "&Cherry" },
    { "&Date" },
    { "--" },
    { "&Elderberry" },
    { "&Fig" },
  })
end, { desc = "Test: minimal context menu" })

vim.notify(
  "Context menu tests loaded!\n"
    .. "  <leader>t1 - Basic menu with hotkeys & descriptions\n"
    .. "  <leader>t2 - Menu with callbacks\n"
    .. "  <leader>t3 - Menu with disabled items\n"
    .. "  <leader>t4 - Centered menu\n"
    .. "  <leader>t5 - Minimal menu (no descriptions)",
  vim.log.levels.INFO
)
