-- Test script for venux.ui.inputbox
-- Run with:  nvim -c "luafile lua/tests/test_inputbox.lua"

local inputbox = require("venux.ui.inputbox")

-- ── Test 1: Basic input ──
vim.keymap.set("n", "<leader>i1", function()
  local result = inputbox.open("Enter your name:", {
    title = " Basic Input ",
  })
  if result then
    vim.notify("You entered: " .. result, vim.log.levels.INFO)
  else
    vim.notify("Cancelled", vim.log.levels.WARN)
  end
end, { desc = "Test: basic inputbox" })

-- ── Test 2: With default text ──
vim.keymap.set("n", "<leader>i2", function()
  local result = inputbox.open("Rename file:", {
    title = " Rename ",
    text = "init.lua",
  })
  if result then
    vim.notify("New name: " .. result, vim.log.levels.INFO)
  else
    vim.notify("Cancelled", vim.log.levels.WARN)
  end
end, { desc = "Test: inputbox with default text" })

-- ── Test 3: Multi-line prompt ──
vim.keymap.set("n", "<leader>i3", function()
  local result = inputbox.open({
    "Search and Replace",
    "Enter the replacement text below:",
    "(original: foo_bar_baz)",
  }, {
    title = " Replace ",
    text = "foo_bar_baz",
    w = 60,
  })
  if result then
    vim.notify("Replace with: " .. result, vim.log.levels.INFO)
  else
    vim.notify("Cancelled", vim.log.levels.WARN)
  end
end, { desc = "Test: inputbox with multi-line prompt" })

-- ── Test 4: With history ──
vim.keymap.set("n", "<leader>i4", function()
  local result = inputbox.open("Search pattern:", {
    title = " Search ",
    history = "search_test",
  })
  if result then
    vim.notify("Search: " .. result .. "\n(press <leader>i4 again, use Up/Down for history)", vim.log.levels.INFO)
  else
    vim.notify("Cancelled", vim.log.levels.WARN)
  end
end, { desc = "Test: inputbox with history (Up/Down)" })

-- ── Test 5: Allow empty input ──
vim.keymap.set("n", "<leader>i5", function()
  local result = inputbox.open("Optional comment (can be empty):", {
    title = " Comment ",
    strict = false,
  })
  if result then
    if result == "" then
      vim.notify("Empty comment accepted", vim.log.levels.INFO)
    else
      vim.notify("Comment: " .. result, vim.log.levels.INFO)
    end
  else
    vim.notify("Cancelled (Esc)", vim.log.levels.WARN)
  end
end, { desc = "Test: inputbox allowing empty input" })

vim.notify(
  "Inputbox tests loaded!\n"
    .. "  <leader>i1 - Basic input\n"
    .. "  <leader>i2 - With default text (try Home/End, Ctrl-A/E)\n"
    .. "  <leader>i3 - Multi-line prompt + wide box\n"
    .. "  <leader>i4 - With history (Up/Down arrows)\n"
    .. "  <leader>i5 - Allow empty input (strict=false)",
  vim.log.levels.INFO
)
