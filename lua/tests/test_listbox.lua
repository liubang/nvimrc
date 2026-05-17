-- Test script for venux.ui.listbox
-- Run with:  nvim -c "luafile lua/tests/test_listbox.lua"

local listbox = require("venux.ui.listbox")

-- ── Test 1: Basic listbox with hotkeys and descriptions ──
vim.keymap.set("n", "<leader>l1", function()
  local idx = listbox.open({
    "Open &File\tCtrl+O",
    "&Edit Buffer\tCtrl+E",
    "&Save\tCtrl+S",
    "Save &All\tCtrl+Shift+S",
    "&Quit\tCtrl+Q",
  }, {
    title = " File Operations ",
    w = 150,
  })
  vim.notify("Selected index: " .. idx)
end, { desc = "Test: basic listbox" })

-- ── Test 2: Long scrollable list ──
vim.keymap.set("n", "<leader>l2", function()
  local items = {}
  for i = 1, 50 do
    table.insert(items, string.format("Item %02d\tDescription for item %d", i, i))
  end
  local idx = listbox.open(items, {
    title = " Long List (50 items) ",
    w = 150,
    h = 15,
  })
  vim.notify("Selected index: " .. idx)
end, { desc = "Test: long scrollable listbox" })

-- ── Test 3: With callbacks ──
vim.keymap.set("n", "<leader>l3", function()
  listbox.open({
    {
      "&Apple",
      cmd = function()
        vim.notify("You picked Apple!")
      end,
    },
    {
      "&Banana",
      cmd = function()
        vim.notify("You picked Banana!")
      end,
    },
    {
      "&Cherry",
      cmd = function()
        vim.notify("You picked Cherry!")
      end,
    },
    {
      "&Date",
      cmd = function()
        vim.notify("You picked Date!")
      end,
    },
    {
      "&Elderberry",
      cmd = function()
        vim.notify("You picked Elderberry!")
      end,
    },
    {
      "&Fig",
      cmd = function()
        vim.notify("You picked Fig!")
      end,
    },
    {
      "&Grape",
      cmd = function()
        vim.notify("You picked Grape!")
      end,
    },
  }, {
    title = " Pick a Fruit ",
  })
end, { desc = "Test: listbox with callbacks" })

-- ── Test 4: Search demo (try pressing / to search) ──
vim.keymap.set("n", "<leader>l4", function()
  local langs = {
    "Assembly",
    "Bash",
    "C",
    "C++",
    "C#",
    "Clojure",
    "Dart",
    "Elixir",
    "Erlang",
    "Go",
    "Haskell",
    "Java",
    "JavaScript",
    "Julia",
    "Kotlin",
    "Lua",
    "Nim",
    "OCaml",
    "Perl",
    "PHP",
    "Python",
    "R",
    "Ruby",
    "Rust",
    "Scala",
    "Swift",
    "TypeScript",
    "V",
    "Zig",
  }
  local idx = listbox.open(langs, {
    title = " Languages (press / to search) ",
    h = 12,
  })
  if idx >= 0 then
    vim.notify("Selected: " .. langs[idx + 1])
  end
end, { desc = "Test: listbox with search" })

-- ── Test 5: Fixed width, initial index ──
vim.keymap.set("n", "<leader>l5", function()
  local idx = listbox.open({
    "First",
    "Second",
    "Third",
    "Fourth",
    "Fifth",
  }, {
    title = " Start at Third ",
    w = 40,
    index = 2, -- 0-based, so "Third"
  })
  vim.notify("Selected index: " .. idx)
end, { desc = "Test: listbox with fixed width and initial index" })

vim.notify(
  "Listbox tests loaded!\n"
    .. "  <leader>l1 - Basic listbox\n"
    .. "  <leader>l2 - Long scrollable list (50 items)\n"
    .. "  <leader>l3 - Listbox with callbacks\n"
    .. "  <leader>l4 - Search demo (press / to search, n/N to jump)\n"
    .. "  <leader>l5 - Fixed width, initial index",
  vim.log.levels.INFO
)
