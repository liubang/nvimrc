-- Test script for venux.ui.multi_select
-- Run with:  nvim -c "luafile lua/tests/test_multi_select.lua"

local multi_select = require("venux.ui.multi_select")

--- Helper: format selected result for notification.
---@param selected any[]|nil
---@return string
local function fmt(selected)
  if not selected then
    return "nil (cancelled or nothing selected)"
  end
  local parts = {}
  for _, v in ipairs(selected) do
    table.insert(parts, tostring(v))
  end
  return "{ " .. table.concat(parts, ", ") .. " }"
end

-- ── Test 1: Basic string list (default: all checked) ──
vim.keymap.set("n", "<leader>m1", function()
  local selected = multi_select.open("Pick your favorite fruits:", {
    "Apple",
    "Banana",
    "Cherry",
    "Date",
    "Elderberry",
  }, {
    title = " Fruits ",
  })
  vim.notify("Selected: " .. fmt(selected), vim.log.levels.INFO)
end, { desc = "Test: basic multi-select (all checked)" })

-- ── Test 2: Default unchecked ──
vim.keymap.set("n", "<leader>m2", function()
  local selected = multi_select.open("Select languages to install:", {
    "Lua",
    "Python",
    "Rust",
    "Go",
    "TypeScript",
    "C++",
  }, {
    title = " Languages ",
    default_checked = false,
  })
  vim.notify("Selected: " .. fmt(selected), vim.log.levels.INFO)
end, { desc = "Test: multi-select (none checked)" })

-- ── Test 3: With format_item (table values) ──
vim.keymap.set("n", "<leader>m3", function()
  local plugins = {
    { name = "telescope.nvim", stars = 12000 },
    { name = "nvim-treesitter", stars = 9500 },
    { name = "lazy.nvim", stars = 11000 },
    { name = "nvim-lspconfig", stars = 8800 },
    { name = "mason.nvim", stars = 6500 },
  }
  local selected = multi_select.open("Choose plugins to install:", plugins, {
    title = " Plugins ",
    format_item = function(item)
      return string.format("%-20s ★ %d", item.name, item.stars)
    end,
    default_checked = false,
  })
  if selected then
    local names = {}
    for _, p in ipairs(selected) do
      table.insert(names, p.name)
    end
    vim.notify("Installing: " .. table.concat(names, ", "), vim.log.levels.INFO)
  else
    vim.notify("No plugins selected.", vim.log.levels.WARN)
  end
end, { desc = "Test: multi-select with format_item" })

-- ── Test 4: Long list (test scrolling with g/G) ──
vim.keymap.set("n", "<leader>m4", function()
  local items = {}
  for i = 1, 30 do
    table.insert(items, string.format("Item %02d - %s", i, string.rep("x", math.random(5, 20))))
  end
  local selected = multi_select.open("Select items (30 total, test g/G navigation):", items, {
    title = " Long List ",
    default_checked = false,
    max_height = 0.5,
  })
  local count = selected and #selected or 0
  vim.notify("Selected " .. count .. " of 30 items: " .. fmt(selected), vim.log.levels.INFO)
end, { desc = "Test: long list (30 items)" })

-- ── Test 5: Single item ──
vim.keymap.set("n", "<leader>m5", function()
  local selected = multi_select.open("Confirm action:", { "Enable dark mode" }, {
    title = " Toggle ",
  })
  vim.notify("Selected: " .. fmt(selected), vim.log.levels.INFO)
end, { desc = "Test: single item" })

-- ── Test 6: Custom border and width ──
vim.keymap.set("n", "<leader>m6", function()
  local selected = multi_select.open("Choose notification channels:", {
    "Email",
    "Slack",
    "DingTalk",
    "WeChat",
    "SMS",
  }, {
    title = " Notifications ",
    border = "rounded",
    default_checked = true,
    min_width = 0.4,
    max_width = 0.5,
  })
  vim.notify("Selected: " .. fmt(selected), vim.log.levels.INFO)
end, { desc = "Test: custom border & width" })

vim.notify(
  "Multi-select tests loaded!\n"
    .. "  <leader>m1 - Basic (all checked)\n"
    .. "  <leader>m2 - Default unchecked\n"
    .. "  <leader>m3 - format_item (table values)\n"
    .. "  <leader>m4 - Long list (30 items)\n"
    .. "  <leader>m5 - Single item\n"
    .. "  <leader>m6 - Custom border & width\n"
    .. "\n"
    .. "Keys: j/k move, Space toggle, a=all, n=none, g/G jump, CR confirm, q/Esc cancel",
  vim.log.levels.INFO
)
