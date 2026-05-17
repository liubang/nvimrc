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
-- Created: 2026/05/17 14:47

--- A scrollable listbox floating window UI component.
--- Supports hotkeys, multi-column alignment, "/" incremental search,
--- PageUp/PageDown, and half-page scrolling.
---
--- Item format (same as context_menu):
---   - "Open &File\tCtrl+O"   -- & marks hotkey, \t separates description
---   - Table form: { "text", cmd = function() end }
---
--- Usage:
---   local listbox = require("venux.ui.listbox")
---   local idx = listbox.open({
---     "Item &One\tdescription",
---     "Item &Two\tanother",
---     { "Item &Three", cmd = function() vim.notify("three!") end },
---   }, {
---     title = " Pick One ",
---     w = 50,
---     h = 10,
---   })

local M = {}

local ns = vim.api.nvim_create_namespace("venux_ui_listbox")

---@class ListboxItem
---@field [1] string              Display text with optional &hotkey and \t description
---@field cmd? string|fun()       Command or callback when selected

---@class ListboxOpts
---@field title? string           Window title
---@field border? string|string[] Border style (default: "single")
---@field w? number               Fixed width (auto-calculated if omitted)
---@field h? number               Fixed height (auto-calculated if omitted, clamped to editor)
---@field max_height? number      Max height ratio 0-1 (default: 0.7)
---@field index? number           Initial cursor position, 0-based (default: 0)
---@field ignore_case? boolean    Case-insensitive hotkey matching (default: true)
---@field syntax? string          Optional filetype for syntax highlighting

-- Highlight groups
local function setup_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "VenuxListboxNormal", { link = "NormalFloat", default = true })
  hl(0, "VenuxListboxBorder", { link = "FloatBorder", default = true })
  hl(0, "VenuxListboxTitle", { link = "FloatTitle", default = true })
  hl(0, "VenuxListboxCursor", { link = "PmenuSel", default = true })
  hl(0, "VenuxListboxHotkey", { link = "Underlined", default = true })
  hl(0, "VenuxListboxSearch", { link = "Search", default = true })
end

---@class ParsedListItem
---@field text string         Left-side display text (without &)
---@field desc string         Right-side description
---@field hotkey string|nil   The hotkey character
---@field hotkey_col number   Byte offset of hotkey in text (0-based), -1 if none
---@field cmd string|fun()|nil
---@field index number        0-based

--- Parse a single item.
---@param item ListboxItem|string
---@param idx number 0-based
---@return ParsedListItem
local function parse_item(item, idx)
  local raw, cmd
  if type(item) == "string" then
    raw, cmd = item, nil
  elseif type(item) == "table" then
    raw, cmd = item[1] or "", item.cmd
  else
    raw, cmd = tostring(item), nil
  end

  local text_part, desc_part = raw, ""
  local tab_pos = raw:find("\t", 1, true)
  if tab_pos then
    text_part = raw:sub(1, tab_pos - 1)
    desc_part = raw:sub(tab_pos + 1)
  end

  local hotkey, hotkey_col, display_text = nil, -1, text_part
  local amp_pos = text_part:find("&", 1, true)
  if amp_pos and amp_pos < #text_part then
    hotkey = text_part:sub(amp_pos + 1, amp_pos + 1)
    display_text = text_part:sub(1, amp_pos - 1) .. text_part:sub(amp_pos + 1)
    hotkey_col = amp_pos - 1
  end

  return {
    text = display_text,
    desc = desc_part,
    hotkey = hotkey,
    hotkey_col = hotkey_col,
    cmd = cmd,
    index = idx,
  }
end

--- Build display lines with column alignment.
---@param items ParsedListItem[]
---@return string[] lines, number text_width, number desc_width
local function build_lines(items)
  local text_w, desc_w = 0, 0
  for _, item in ipairs(items) do
    text_w = math.max(text_w, vim.fn.strdisplaywidth(item.text))
    desc_w = math.max(desc_w, vim.fn.strdisplaywidth(item.desc))
  end

  local gap = desc_w > 0 and 2 or 0
  local lines = {}
  for _, item in ipairs(items) do
    local text_pad = text_w - vim.fn.strdisplaywidth(item.text)
    local line = " " .. item.text .. string.rep(" ", text_pad)
    if desc_w > 0 then
      local desc_pad = desc_w - vim.fn.strdisplaywidth(item.desc)
      line = line .. "  " .. string.rep(" ", desc_pad) .. item.desc
    end
    line = line .. " "
    table.insert(lines, line)
  end
  return lines, text_w, desc_w
end

--- Apply highlights for visible range.
---@param buf number
---@param win number
---@param items ParsedListItem[]
---@param cursor number 1-based
---@param text_width number
---@param search_pattern? string
local function apply_highlights(buf, win, items, cursor, text_width, search_pattern)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

  -- Cursor line highlight
  if cursor >= 1 and cursor <= #items then
    local line_idx = cursor - 1
    local line_text = vim.api.nvim_buf_get_lines(buf, line_idx, line_idx + 1, false)[1] or ""
    vim.api.nvim_buf_set_extmark(buf, ns, line_idx, 0, {
      end_row = line_idx,
      end_col = #line_text,
      hl_group = "VenuxListboxCursor",
    })
  end

  -- Hotkey highlights (skip cursor line, it's fully highlighted)
  for i, item in ipairs(items) do
    if i ~= cursor and item.hotkey_col >= 0 then
      local line_idx = i - 1
      local col_start = 1 + item.hotkey_col -- 1 for leading space
      local col_end = col_start + #item.hotkey
      local line_text = vim.api.nvim_buf_get_lines(buf, line_idx, line_idx + 1, false)[1] or ""
      if col_end <= #line_text then
        vim.api.nvim_buf_set_extmark(buf, ns, line_idx, col_start, {
          end_row = line_idx,
          end_col = col_end,
          hl_group = "VenuxListboxHotkey",
        })
      end
    end
  end

  -- Search match highlights
  if search_pattern and search_pattern ~= "" then
    local ok, regex = pcall(vim.regex, search_pattern)
    if ok then
      for i = 1, #items do
        local line_idx = i - 1
        local line_text = vim.api.nvim_buf_get_lines(buf, line_idx, line_idx + 1, false)[1] or ""
        local s, e = regex:match_str(line_text)
        if s then
          vim.api.nvim_buf_set_extmark(buf, ns, line_idx, s, {
            end_row = line_idx,
            end_col = e,
            hl_group = "VenuxListboxSearch",
          })
        end
      end
    end
  end
end

--- Ensure cursor line is visible in the window, adjusting scroll.
---@param win number
---@param cursor number 1-based line
---@param total number total lines
---@param win_h number window height
local function ensure_visible(win, cursor, total, win_h)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  -- Set cursor position, Neovim will auto-scroll
  pcall(vim.api.nvim_win_set_cursor, win, { math.min(cursor, total), 0 })
end

--- Open a listbox. Blocks via getchar() loop.
---@param items (ListboxItem|string)[] Item definitions
---@param opts? ListboxOpts
---@return number 0-based index of selected item, or -1 if cancelled
function M.open(items, opts)
  if not items or #items == 0 then
    return -1
  end

  opts = opts or {}
  local title = opts.title
  local border = opts.border or "single"
  local max_height = opts.max_height or 0.7
  local ignore_case = opts.ignore_case ~= false
  local init_index = opts.index or 0

  setup_highlights()

  -- Parse items
  local parsed = {}
  for i, item in ipairs(items) do
    table.insert(parsed, parse_item(item, i - 1))
  end

  -- Build hotkey map
  local hotkeys = {}
  for _, item in ipairs(parsed) do
    if item.hotkey then
      local key = ignore_case and item.hotkey:lower() or item.hotkey
      if not hotkeys[key] then
        hotkeys[key] = item.index + 1 -- 1-based
      end
    end
  end

  -- Build lines
  local lines, text_w, desc_w = build_lines(parsed)

  -- Calculate window size
  local max_line_w = 0
  for _, line in ipairs(lines) do
    max_line_w = math.max(max_line_w, vim.fn.strdisplaywidth(line))
  end
  local title_w = title and (vim.fn.strdisplaywidth(title) + 2) or 0
  local win_w = opts.w or math.max(max_line_w, title_w)
  local win_h = opts.h or math.min(#lines, math.floor(vim.o.lines * max_height))
  -- Clamp
  win_w = math.min(win_w, vim.o.columns - 4)
  win_h = math.min(win_h, vim.o.lines - 4)
  win_w = math.max(win_w, 10)
  win_h = math.max(win_h, 1)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Center the window
  local row = math.floor((vim.o.lines - win_h) / 2)
  local col = math.floor((vim.o.columns - win_w) / 2)
  row = math.max(0, row)
  col = math.max(0, col)

  local win_opts = {
    relative = "editor",
    row = row,
    col = col,
    width = win_w,
    height = win_h,
    style = "minimal",
    border = border,
    noautocmd = true,
  }
  if title then
    win_opts.title = title
    win_opts.title_pos = "center"
  end

  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.wo[win].winhl = "Normal:VenuxListboxNormal,FloatBorder:VenuxListboxBorder,FloatTitle:VenuxListboxTitle"
  vim.wo[win].cursorline = false
  vim.wo[win].wrap = false
  vim.wo[win].scrolloff = 2

  -- Optional syntax
  if opts.syntax then
    vim.bo[buf].filetype = opts.syntax
  end

  -- State
  local cursor = math.min(init_index + 1, #parsed)
  cursor = math.max(1, cursor)
  local search_pattern = nil

  local function render()
    apply_highlights(buf, win, parsed, cursor, text_w, search_pattern)
    ensure_visible(win, cursor, #parsed, win_h)
    vim.cmd.redraw()
  end

  --- Cleanup: close window and buffer.
  local function cleanup()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
    -- Clear cmdline and redraw
    vim.api.nvim_echo({ { "", "" } }, false, {})
    vim.cmd.redraw()
  end

  render()

  --- Incremental search: read a pattern from the user in the cmdline area.
  ---@return string|nil pattern, or nil if cancelled
  local function read_search()
    local pattern = ""
    vim.api.nvim_echo({ { "/", "Question" } }, false, {})
    vim.cmd.redraw()
    while true do
      local ok, code = pcall(vim.fn.getchar)
      if not ok then
        return nil
      end
      local ch = type(code) == "number" and vim.fn.nr2char(code) or code
      if ch == "\r" then
        return pattern
      elseif ch == "\27" then
        return nil
      elseif ch == "\b" or ch == "\127" or ch == "\x80kb" then
        -- Backspace (UTF-8 safe)
        if #pattern > 0 then
          local nchars = vim.fn.strchars(pattern)
          pattern = vim.fn.strcharpart(pattern, 0, nchars - 1)
        end
      else
        pattern = pattern .. ch
      end
      -- Show current pattern in cmdline
      vim.api.nvim_echo({ { "/" .. pattern, "Question" } }, false, {})
      -- Live highlight preview
      search_pattern = #pattern > 0 and pattern or nil
      apply_highlights(buf, win, parsed, cursor, text_w, search_pattern)
      vim.cmd.redraw()
    end
  end

  --- Jump to next/prev search match.
  ---@param direction number 1 for next, -1 for prev
  local function search_jump(direction)
    if not search_pattern or search_pattern == "" then
      return
    end
    local ok, regex = pcall(vim.regex, search_pattern)
    if not ok then
      return
    end
    local start = cursor
    local i = start
    for _ = 1, #parsed do
      i = i + direction
      if i < 1 then
        i = #parsed
      elseif i > #parsed then
        i = 1
      end
      local line_text = lines[i] or ""
      if regex:match_str(line_text) then
        cursor = i
        return
      end
    end
  end

  -- ── Event loop (wrapped in pcall to guarantee cleanup) ──
  local retval = -1

  local loop_ok, loop_err = pcall(function()
    while true do
      local ok, code = pcall(vim.fn.getchar)
      if not ok then
        break
      end

      local ch = type(code) == "number" and vim.fn.nr2char(code) or code
      if ch == "" then
        -- noop
      elseif ch == "\27" or ch == "q" then
        break
      elseif ch == "\r" or ch == " " then
        retval = parsed[cursor].index
        break
      elseif ch == "j" or ch == "\x80kd" then
        cursor = cursor < #parsed and cursor + 1 or 1
        render()
      elseif ch == "k" or ch == "\x80ku" then
        cursor = cursor > 1 and cursor - 1 or #parsed
        render()
      elseif ch == "g" then
        cursor = 1
        render()
      elseif ch == "G" then
        cursor = #parsed
        render()
      elseif ch == "\x06" then -- Ctrl-F / PageDown
        cursor = math.min(cursor + win_h, #parsed)
        render()
      elseif ch == "\x02" then -- Ctrl-B / PageUp
        cursor = math.max(cursor - win_h, 1)
        render()
      elseif ch == "\x04" then -- Ctrl-D / half page down
        cursor = math.min(cursor + math.floor(win_h / 2), #parsed)
        render()
      elseif ch == "\x15" then -- Ctrl-U / half page up
        cursor = math.max(cursor - math.floor(win_h / 2), 1)
        render()
      elseif ch == "/" then
        local pat = read_search()
        if pat and pat ~= "" then
          search_pattern = pat
          search_jump(1)
        end
        -- Clear cmdline
        vim.api.nvim_echo({ { "", "" } }, false, {})
        render()
      elseif ch == "n" then
        search_jump(1)
        render()
      elseif ch == "N" then
        search_jump(-1)
        render()
      else
        -- Check hotkey
        local match_key = ignore_case and ch:lower() or ch
        if hotkeys[match_key] then
          retval = parsed[hotkeys[match_key]].index
          break
        end
      end
    end
  end)

  -- Always cleanup, even if the event loop errored
  cleanup()

  -- Re-raise if the loop errored (after cleanup)
  if not loop_ok then
    error(loop_err, 0)
  end

  -- Execute command if selected
  if retval >= 0 then
    local item = parsed[retval + 1]
    if item and item.cmd then
      if type(item.cmd) == "function" then
        item.cmd()
      elseif type(item.cmd) == "string" and item.cmd ~= "" then
        vim.cmd(item.cmd)
      end
    end
  end

  return retval
end

return M
