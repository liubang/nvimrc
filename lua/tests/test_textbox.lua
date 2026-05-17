-- Test script for venux.ui.textbox
-- Run with:  nvim -c "luafile lua/tests/test_textbox.lua"

local textbox = require("venux.ui.textbox")

-- ── Test 1: Plain text ──
vim.keymap.set("n", "<leader>b1", function()
  local lines = {}
  for i = 1, 100 do
    table.insert(lines, string.format("Line %03d: The quick brown fox jumps over the lazy dog.", i))
  end
  textbox.open(lines, {
    title = " Plain Text (100 lines) ",
  })
end, { desc = "Test: plain text textbox" })

-- ── Test 2: With syntax highlighting ──
vim.keymap.set("n", "<leader>b2", function()
  local code = {
    "local M = {}",
    "",
    "--- Greet someone.",
    "---@param name string",
    "---@return string",
    "function M.greet(name)",
    '  return "Hello, " .. name .. "!"',
    "end",
    "",
    "-- A table of colors",
    "M.colors = {",
    '  red   = "#ff0000",',
    '  green = "#00ff00",',
    '  blue  = "#0000ff",',
    "}",
    "",
    "for k, v in pairs(M.colors) do",
    "  print(k, v)",
    "end",
    "",
    "return M",
  }
  textbox.open(code, {
    title = " Lua Code Preview ",
    syntax = "lua",
    number = true,
  })
end, { desc = "Test: textbox with syntax + line numbers" })

-- ── Test 3: Shell command output ──
vim.keymap.set("n", "<leader>b3", function()
  textbox.command("git log --oneline -30", {
    title = " Git Log ",
  })
end, { desc = "Test: textbox from shell command" })

-- ── Test 4: Long wrapped text ──
vim.keymap.set("n", "<leader>b4", function()
  local lines = {
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    "",
    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    "",
    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
    "",
    "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
  }
  textbox.open(lines, {
    title = " Wrapped Text ",
    w = 60,
    wrap = true,
  })
end, { desc = "Test: textbox with wrapped text" })

-- ── Test 5: JSON with syntax ──
vim.keymap.set("n", "<leader>b5", function()
  local json = {
    "{",
    '  "name": "venux-ui",',
    '  "version": "1.0.0",',
    '  "components": [',
    '    "multi_select",',
    '    "context_menu",',
    '    "listbox",',
    '    "textbox"',
    "  ],",
    '  "features": {',
    '    "search": true,',
    '    "syntax_highlight": true,',
    '    "line_numbers": true,',
    '    "scrolling": true,',
    '    "hotkeys": true',
    "  }",
    "}",
  }
  textbox.open(json, {
    title = " JSON Preview ",
    syntax = "json",
    number = true,
  })
end, { desc = "Test: textbox with JSON syntax" })

vim.notify(
  "Textbox tests loaded!\n"
    .. "  <leader>b1 - Plain text (100 lines, try / search, Ctrl-F/B scroll)\n"
    .. "  <leader>b2 - Lua code with syntax + line numbers\n"
    .. "  <leader>b3 - Shell command output (git log)\n"
    .. "  <leader>b4 - Wrapped long text\n"
    .. "  <leader>b5 - JSON with syntax + line numbers",
  vim.log.levels.INFO
)
