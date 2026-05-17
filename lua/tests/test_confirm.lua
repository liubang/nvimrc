-- Test script for venux.ui.confirm
-- Run with:  nvim -c "luafile lua/tests/test_confirm.lua"

local confirm = require("venux.ui.confirm")

-- ── Test 1: Basic OK dialog ──
vim.keymap.set("n", "<leader>c1", function()
  local choice = confirm.open("Operation completed successfully.", {
    title = " Info ",
  })
  vim.notify("Choice: " .. choice .. (choice == 1 and " (OK)" or " (Cancelled)"), vim.log.levels.INFO)
end, { desc = "Test: basic confirm (OK only)" })

-- ── Test 2: Yes / No ──
vim.keymap.set("n", "<leader>c2", function()
  local choice = confirm.open("Save changes before closing?", {
    title = " Save ",
    choices = { "&Yes", "&No" },
  })
  local labels = { "Yes", "No" }
  local label = labels[choice] or "Cancelled"
  vim.notify("Choice: " .. choice .. " (" .. label .. ")", vim.log.levels.INFO)
end, { desc = "Test: Yes/No confirm" })

-- ── Test 3: Yes / No / Cancel with default on No ──
vim.keymap.set("n", "<leader>c3", function()
  local choice = confirm.open("Do you want to save changes?", {
    title = " Confirm ",
    choices = { "&Yes", "&No", "&Cancel" },
    default = 2,
  })
  local labels = { "Yes", "No", "Cancel" }
  local label = labels[choice] or "Cancelled (Esc)"
  vim.notify("Choice: " .. choice .. " (" .. label .. ")", vim.log.levels.INFO)
end, { desc = "Test: Yes/No/Cancel with default=2" })

-- ── Test 4: Multi-line prompt ──
vim.keymap.set("n", "<leader>c4", function()
  local choice = confirm.open({
    "The file has been modified externally.",
    "Do you want to reload it from disk?",
    "",
    "Unsaved changes will be lost.",
  }, {
    title = " Reload ",
    choices = { "&Reload", "&Keep mine", "&Diff" },
  })
  local labels = { "Reload", "Keep mine", "Diff" }
  local label = labels[choice] or "Cancelled"
  vim.notify("Choice: " .. choice .. " (" .. label .. ")", vim.log.levels.INFO)
end, { desc = "Test: multi-line prompt with 3 buttons" })

-- ── Test 5: Pipe-separated choices (vim-confirm style) ──
vim.keymap.set("n", "<leader>c5", function()
  local choice = confirm.open("Delete this buffer permanently?", {
    title = " Delete ",
    choices = "&Delete|&Cancel",
    default = 2,
  })
  local labels = { "Delete", "Cancel" }
  local label = labels[choice] or "Cancelled (Esc)"
  vim.notify("Choice: " .. choice .. " (" .. label .. ")", vim.log.levels.INFO)
end, { desc = "Test: pipe-separated choices" })

-- ── Test 6: Many buttons (stress test) ──
vim.keymap.set("n", "<leader>c6", function()
  local choice = confirm.open("Choose an action:", {
    title = " Actions ",
    choices = { "&Apply", "&Build", "&Clean", "&Deploy", "&Exit" },
  })
  local labels = { "Apply", "Build", "Clean", "Deploy", "Exit" }
  local label = labels[choice] or "Cancelled"
  vim.notify("Choice: " .. choice .. " (" .. label .. ")", vim.log.levels.INFO)
end, { desc = "Test: many buttons" })

vim.notify(
  "Confirm tests loaded!\n"
    .. "  <leader>c1 - Basic OK\n"
    .. "  <leader>c2 - Yes/No\n"
    .. "  <leader>c3 - Yes/No/Cancel (default=No)\n"
    .. "  <leader>c4 - Multi-line prompt + 3 buttons\n"
    .. "  <leader>c5 - Pipe-separated choices\n"
    .. "  <leader>c6 - Many buttons (5)",
  vim.log.levels.INFO
)
