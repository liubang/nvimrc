-- Copyright (c) 2026 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

--[[
KeyFinder — fuzzy-searchable command palette for keymaps and commands.

Uses Snacks.nvim picker as the UI backend.
Includes Neovim built-in keymaps that are not exposed by nvim_get_keymap.
--]]

local M = {}

local MODES = { "n", "v", "x", "s", "i", "c", "t", "o" }

-- ┌──────────────────────────────────────────────────┐
-- │ Built-in Neovim keymaps (not in nvim_get_keymap) │
-- └──────────────────────────────────────────────────┘

-- stylua: ignore start
local BUILTINS = {
  -- motion
  { "n", "h",         "Move left" },
  { "n", "j",         "Move down" },
  { "n", "k",         "Move up" },
  { "n", "l",         "Move right" },
  { "n", "w",         "Move to next word" },
  { "n", "W",         "Move to next WORD" },
  { "n", "b",         "Move to previous word" },
  { "n", "B",         "Move to previous WORD" },
  { "n", "e",         "Move to end of word" },
  { "n", "E",         "Move to end of WORD" },
  { "n", "0",         "Move to start of line" },
  { "n", "^",         "Move to first non-blank" },
  { "n", "$",         "Move to end of line" },
  { "n", "gg",        "Go to first line" },
  { "n", "G",         "Go to last line" },
  { "n", "{",         "Move to previous paragraph" },
  { "n", "}",         "Move to next paragraph" },
  { "n", "(",         "Move to previous sentence" },
  { "n", ")",         "Move to next sentence" },
  { "n", "%",         "Jump to matching bracket" },
  { "n", "f{char}",   "Find char forward" },
  { "n", "F{char}",   "Find char backward" },
  { "n", "t{char}",   "Till char forward" },
  { "n", "T{char}",   "Till char backward" },
  { "n", ";",         "Repeat last f/F/t/T" },
  { "n", ",",         "Repeat last f/F/t/T reversed" },
  { "n", "H",         "Move cursor to top of screen" },
  { "n", "M",         "Move cursor to middle of screen" },
  { "n", "L",         "Move cursor to bottom of screen" },
  { "n", "<C-u>",     "Half page up" },
  { "n", "<C-d>",     "Half page down" },
  { "n", "<C-b>",     "Page up" },
  { "n", "<C-f>",     "Page down" },
  { "n", "<C-o>",     "Jump to older position in jump list" },
  { "n", "<C-i>",     "Jump to newer position in jump list" },

  -- editing
  { "n", "i",         "Insert before cursor" },
  { "n", "I",         "Insert at start of line" },
  { "n", "a",         "Append after cursor" },
  { "n", "A",         "Append at end of line" },
  { "n", "o",         "Open line below" },
  { "n", "O",         "Open line above" },
  { "n", "x",         "Delete character under cursor" },
  { "n", "X",         "Delete character before cursor" },
  { "n", "r{char}",   "Replace character" },
  { "n", "R",         "Enter replace mode" },
  { "n", "s",         "Delete char and insert" },
  { "n", "S",         "Delete line and insert" },
  { "n", "J",         "Join lines" },
  { "n", "u",         "Undo" },
  { "n", "<C-r>",     "Redo" },
  { "n", ".",         "Repeat last change" },
  { "n", "~",         "Toggle case" },

  -- delete / change / yank
  { "n", "dd",        "Delete line" },
  { "n", "D",         "Delete to end of line" },
  { "n", "cc",        "Change line" },
  { "n", "C",         "Change to end of line" },
  { "n", "yy",        "Yank line" },
  { "n", "Y",         "Yank to end of line" },
  { "n", "p",         "Paste after cursor" },
  { "n", "P",         "Paste before cursor" },
  { "n", "dw",        "Delete word" },
  { "n", "diw",       "Delete inner word" },
  { "n", "daw",       "Delete a word (with space)" },
  { "n", "di\"",      "Delete inside double quotes" },
  { "n", "di'",       "Delete inside single quotes" },
  { "n", "di(",       "Delete inside parentheses" },
  { "n", "di{",       "Delete inside braces" },
  { "n", "di[",       "Delete inside brackets" },
  { "n", "ciw",       "Change inner word" },
  { "n", "caw",       "Change a word (with space)" },
  { "n", "ci\"",      "Change inside double quotes" },
  { "n", "ci'",       "Change inside single quotes" },
  { "n", "ci(",       "Change inside parentheses" },
  { "n", "ci{",       "Change inside braces" },
  { "n", "ci[",       "Change inside brackets" },

  -- search
  { "n", "/",         "Search forward" },
  { "n", "?",         "Search backward" },
  { "n", "*",         "Search word under cursor (forward)" },
  { "n", "#",         "Search word under cursor (backward)" },
  { "n", "n",         "Repeat search forward" },
  { "n", "N",         "Repeat search backward" },

  -- marks
  { "n", "m{a-zA-Z}", "Set mark" },
  { "n", "'{a-zA-Z}", "Jump to mark (line)" },
  { "n", "`{a-zA-Z}", "Jump to mark (exact)" },
  { "n", "''",        "Jump to last jump position" },
  { "n", "``",        "Jump to last jump position (exact)" },

  -- registers
  { "n", "\"{reg}",   "Use register for next delete/yank/put" },
  { "n", "q{a-z}",    "Record macro into register" },
  { "n", "q",         "Stop recording macro" },
  { "n", "@{a-z}",    "Execute macro from register" },
  { "n", "@@",        "Repeat last macro" },

  -- window
  { "n", "<C-w>s",    "Split window horizontally" },
  { "n", "<C-w>v",    "Split window vertically" },
  { "n", "<C-w>w",    "Cycle through windows" },
  { "n", "<C-w>h",    "Move to left window" },
  { "n", "<C-w>j",    "Move to window below" },
  { "n", "<C-w>k",    "Move to window above" },
  { "n", "<C-w>l",    "Move to right window" },
  { "n", "<C-w>c",    "Close current window" },
  { "n", "<C-w>o",    "Close all other windows" },
  { "n", "<C-w>=",    "Make all windows equal size" },
  { "n", "<C-w>+",    "Increase window height" },
  { "n", "<C-w>-",    "Decrease window height" },
  { "n", "<C-w>>",    "Increase window width" },
  { "n", "<C-w><",    "Decrease window width" },

  -- misc
  { "n", "ZZ",        "Save and quit" },
  { "n", "ZQ",        "Quit without saving" },
  { "n", "<C-g>",     "Show file info" },
  { "n", "<C-l>",     "Redraw screen" },
  { "n", "<C-a>",     "Increment number" },
  { "n", "<C-x>",     "Decrement number" },
  { "n", "gf",        "Go to file under cursor" },
  { "n", "gd",        "Go to local definition" },
  { "n", "gD",        "Go to global definition" },
  { "n", "gx",        "Open URL/file under cursor" },
  { "n", "ga",        "Show ASCII value of char" },
  { "n", "g8",        "Show UTF-8 bytes of char" },
  { "n", ">>",        "Indent line" },
  { "n", "<<",        "Unindent line" },

  -- visual mode
  { "v", "d",         "Delete selection" },
  { "v", "y",         "Yank selection" },
  { "v", "c",         "Change selection" },
  { "v", ">",         "Indent selection" },
  { "v", "<",         "Unindent selection" },
  { "v", "~",         "Toggle case of selection" },
  { "v", "u",         "Lowercase selection" },
  { "v", "U",         "Uppercase selection" },
  { "v", "J",         "Join selected lines" },
  { "v", "gq",        "Format selection" },
  { "v", ":",         "Enter command for selection" },
  { "v", "o",         "Move to other end of selection" },

  -- insert mode
  { "i", "<C-h>",     "Delete character before cursor" },
  { "i", "<C-w>",     "Delete word before cursor" },
  { "i", "<C-u>",     "Delete to start of line" },
  { "i", "<C-t>",     "Indent current line" },
  { "i", "<C-d>",     "Unindent current line" },
  { "i", "<C-n>",     "Next completion" },
  { "i", "<C-p>",     "Previous completion" },
  { "i", "<C-r>{reg}","Insert from register" },
  { "i", "<C-o>",     "Execute one normal command" },
  { "i", "<C-[>",     "Exit insert mode (same as Esc)" },

  -- command mode
  { "c", "<C-r>{reg}","Insert from register" },
  { "c", "<C-b>",     "Move to start of command line" },
  { "c", "<C-e>",     "Move to end of command line" },
  { "c", "<C-w>",     "Delete word before cursor" },
  { "c", "<C-u>",     "Delete to start of command line" },

  -- text objects (operator-pending)
  { "o", "iw",        "Inner word" },
  { "o", "aw",        "A word (with space)" },
  { "o", "iW",        "Inner WORD" },
  { "o", "aW",        "A WORD (with space)" },
  { "o", "is",        "Inner sentence" },
  { "o", "as",        "A sentence" },
  { "o", "ip",        "Inner paragraph" },
  { "o", "ap",        "A paragraph" },
  { "o", "i\"",       "Inside double quotes" },
  { "o", "a\"",       "Around double quotes" },
  { "o", "i'",        "Inside single quotes" },
  { "o", "a'",        "Around single quotes" },
  { "o", "i`",        "Inside backticks" },
  { "o", "a`",        "Around backticks" },
  { "o", "i(",        "Inside parentheses" },
  { "o", "a(",        "Around parentheses" },
  { "o", "i{",        "Inside braces" },
  { "o", "a{",        "Around braces" },
  { "o", "i[",        "Inside brackets" },
  { "o", "a[",        "Around brackets" },
  { "o", "i<",        "Inside angle brackets" },
  { "o", "a<",        "Around angle brackets" },
  { "o", "it",        "Inside HTML/XML tag" },
  { "o", "at",        "Around HTML/XML tag" },

  -- fold: creating / deleting
  { "n", "zf{motion}", "Create fold (manual/marker)" },
  { "v", "zf",         "Create fold for selection" },
  { "n", "zF",         "Create fold for [count] lines" },
  { "n", "zd",         "Delete one fold at cursor" },
  { "n", "zD",         "Delete folds recursively at cursor" },
  { "n", "zE",         "Eliminate all folds in window" },

  -- fold: open / close
  { "n", "zo",         "Open one fold under cursor" },
  { "n", "zO",         "Open all folds under cursor recursively" },
  { "n", "zc",         "Close one fold under cursor" },
  { "n", "zC",         "Close all folds under cursor recursively" },
  { "n", "za",         "Toggle fold under cursor" },
  { "n", "zA",         "Toggle all folds under cursor recursively" },
  { "n", "zv",         "View cursor line: open just enough folds" },
  { "n", "zx",         "Undo manually opened/closed folds, re-apply foldlevel" },
  { "n", "zX",         "Re-apply foldlevel, undo all manual fold changes" },

  -- fold: global open / close
  { "n", "zm",         "Fold more: subtract 1 from foldlevel" },
  { "n", "zM",         "Close all folds: set foldlevel to 0" },
  { "n", "zr",         "Fold less: add 1 to foldlevel" },
  { "n", "zR",         "Open all folds: set foldlevel to max" },
  { "n", "zn",         "Fold none: set foldenable off" },
  { "n", "zN",         "Fold normal: set foldenable on" },
  { "n", "zi",         "Toggle foldenable" },

  -- fold: navigation
  { "n", "[z",         "Move to start of current open fold" },
  { "n", "]z",         "Move to end of current open fold" },
  { "n", "zj",         "Move down to start of next fold" },
  { "n", "zk",         "Move up to end of previous fold" },
}
-- stylua: ignore end

---Prettify lhs for display, showing leader prefix clearly.
---@param lhs string
---@return string
local function prettify(lhs)
  -- nvim_get_keymap normalises <Leader> to the actual key (e.g. " " when
  -- mapleader is space).  Handle both the literal and the resolved form.
  local leader = vim.g.mapleader or "\\"
  local result = lhs:gsub("<[Ll]eader>", "<Leader>")
  if leader ~= "\\" then
    -- replace the resolved leader character at the start of lhs
    local esc = leader:gsub("([^%w])", "%%%1")
    result = result:gsub("^" .. esc, "<Leader>")
  end
  return result
end

---Collect keymaps and commands into picker items.
---@return snacks.picker.finder.Item[]
local function collect()
  local items = {} ---@type snacks.picker.finder.Item[]
  local seen = {} ---@type table<string, boolean>

  -- built-in keymaps
  for _, entry in ipairs(BUILTINS) do
    local mode, lhs, desc = entry[1], entry[2], entry[3]
    local key = mode .. ":" .. lhs
    seen[key] = true
    items[#items + 1] = {
      text = mode .. " " .. lhs .. " " .. desc,
      kind = "builtin",
      mode = mode,
      lhs = lhs,
      display_lhs = lhs,
      desc = desc,
    }
  end

  -- user keymaps (buffer-local first, then global; override builtins in seen)
  for _, mode in ipairs(MODES) do
    local maps = vim.api.nvim_buf_get_keymap(0, mode)
    for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
      maps[#maps + 1] = m
    end
    for _, m in ipairs(maps) do
      local lhs = m.lhs or ""
      local desc = m.desc or ""
      if desc ~= "" and not lhs:find("<Plug>", 1, true) and lhs ~= "" then
        local key = mode .. ":" .. lhs
        if not seen[key] then
          seen[key] = true
          local display_lhs = prettify(lhs)
          items[#items + 1] = {
            text = mode .. " " .. display_lhs .. " " .. desc,
            kind = "key",
            mode = mode,
            lhs = lhs,
            display_lhs = display_lhs,
            desc = desc,
            callback = m.callback,
            rhs = m.rhs,
          }
        end
      end
    end
  end

  -- user commands (buffer-local first, then global).
  -- NOTE: nvim_get_commands / nvim_buf_get_commands are deprecated but still
  -- the only API that enumerates user commands.  When a command has a `desc`,
  -- the API puts it in the `definition` field (NOT as "<Lua NNN>").
  local cmd_seen = {} ---@type table<string, boolean>
  for _, source in ipairs({ vim.api.nvim_buf_get_commands(0, {}), vim.api.nvim_get_commands({}) }) do
    for name, def in pairs(source) do
      if type(name) == "string" and not cmd_seen[name] then
        cmd_seen[name] = true
        local desc = def.definition or ""
        if desc:match("^<Lua %d+>") then
          desc = ""
        end
        items[#items + 1] = {
          text = "cmd :" .. name .. " " .. desc,
          kind = "cmd",
          name = name,
          desc = desc,
          nargs = def.nargs,
        }
      end
    end
  end

  return items
end

---Format a single picker item for display.
---@param item snacks.picker.finder.Item
---@return snacks.picker.Highlight[]
local function format(item)
  if item.kind == "key" or item.kind == "builtin" then
    local mode_hl = item.kind == "builtin" and "SnacksPickerDim" or "SnacksPickerIdx"
    return {
      { " " },
      { string.format("%-3s", item.mode), mode_hl },
      { " " },
      { string.format("%-24s", item.display_lhs), "SnacksPickerCmd" },
      { " " },
      { item.desc, "SnacksPickerDesc" },
    }
  else
    return {
      { " " },
      { "cmd", "SnacksPickerLabel" },
      { " " },
      { string.format("%-24s", ":" .. item.name), "SnacksPickerCmd" },
      { " " },
      { item.desc, "SnacksPickerDesc" },
    }
  end
end

---Confirm action: execute the selected keymap or command.
---@param picker snacks.Picker
---@param item snacks.picker.finder.Item
local function confirm(picker, item)
  picker:close()
  if item.kind == "key" then
    local keys = vim.api.nvim_replace_termcodes(item.lhs, true, true, true)
    vim.api.nvim_feedkeys(keys, "mt", false)
  elseif item.kind == "builtin" then
    -- builtins with {char} placeholders can't be executed directly
    if not item.lhs:find("{", 1, true) then
      local keys = vim.api.nvim_replace_termcodes(item.lhs, true, true, true)
      vim.api.nvim_feedkeys(keys, "mt", false)
    end
  elseif item.kind == "cmd" then
    if item.nargs == "0" then
      vim.cmd(item.name)
    else
      vim.api.nvim_feedkeys(":" .. item.name .. " ", "n", false)
    end
  end
end

---Open the KeyFinder picker.
function M.open()
  Snacks.picker({
    title = "KeyFinder",
    finder = function()
      return collect()
    end,
    format = function(item)
      return format(item)
    end,
    confirm = confirm,
    layout = {
      hidden = { "preview" },
    },
  })
end

return M
