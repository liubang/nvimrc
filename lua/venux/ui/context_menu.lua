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
-- Created: 2026/05/17 14:41

--- A context menu (right-click style) floating window UI component.
--- Supports hotkeys (underlined), separators, disabled items, and descriptions.
---
--- Item format (inspired by vim-quickui):
---   - Normal item:  "Open &File\tCtrl+O"
---     "&" marks the hotkey character, "\t" separates the right-aligned description
---   - Separator:    "--" (any string starting with "--")
---   - Disabled item: set enabled = false in the item table form
---
--- Usage:
---   local context_menu = require("venux.ui.context_menu")
---   context_menu.open({
---     { "Open &File\tCtrl+O",  cmd = "edit" },
---     { "&Save\tCtrl+S",       cmd = "write" },
---     { "--" },
---     { "&Quit\tCtrl+Q",       cmd = "quit" },
---   }, {
---     title = " File ",
---     position = "cursor",  -- "cursor" | "center"
---   })

local M = {}

local ns = vim.api.nvim_create_namespace("venux_ui_context_menu")

---@class ContextMenuItem
---@field [1] string                    Display text with optional &hotkey and \t description
---@field cmd? string|fun()             Command to execute or callback when selected
---@field enabled? boolean              Whether the item is selectable (default: true)

---@class ContextMenuOpts
---@field title? string                 Window title
---@field border? string|string[]       Border style (default: "rounded")
---@field position? "cursor"|"center"   Where to show the menu (default: "cursor")
---@field ignore_case? boolean          Case-insensitive hotkey matching (default: true)

-- Highlight groups
local function setup_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "VenuxContextNormal", { link = "NormalFloat", default = true })
  hl(0, "VenuxContextBorder", { link = "FloatBorder", default = true })
  hl(0, "VenuxContextTitle", { link = "FloatTitle", default = true })
  hl(0, "VenuxContextCursor", { link = "PmenuSel", default = true })
  hl(0, "VenuxContextHotkey", { link = "Underlined", default = true })
  hl(0, "VenuxContextDisabled", { link = "Comment", default = true })
  hl(0, "VenuxContextSeparator", { link = "Comment", default = true })
  hl(0, "VenuxContextDesc", { link = "Comment", default = true })
end

---@class ParsedItem
---@field text string         Left-side display text (without &)
---@field desc string         Right-side description
---@field hotkey string|nil   The hotkey character
---@field hotkey_col number   Byte offset of hotkey in text (0-based), -1 if none
---@field is_sep boolean      Whether this is a separator
---@field enabled boolean     Whether this item is selectable
---@field cmd string|fun()|nil  Command or callback
---@field index number        Original 0-based index

--- Parse a single menu item definition.
---@param item ContextMenuItem|string
---@param idx number 0-based index
---@return ParsedItem
local function parse_item(item, idx)
  local raw, cmd, enabled
  if type(item) == "string" then
    raw = item
    cmd = nil
    enabled = true
  elseif type(item) == "table" then
    raw = item[1] or ""
    cmd = item.cmd
    enabled = item.enabled ~= false
  else
    raw = tostring(item)
    cmd = nil
    enabled = true
  end

  -- Separator
  if raw:sub(1, 2) == "--" then
    return {
      text = "",
      desc = "",
      hotkey = nil,
      hotkey_col = -1,
      is_sep = true,
      enabled = false,
      cmd = nil,
      index = idx,
    }
  end

  -- Split by \t for description
  local text_part, desc_part = raw, ""
  local tab_pos = raw:find("\t", 1, true)
  if tab_pos then
    text_part = raw:sub(1, tab_pos - 1)
    desc_part = raw:sub(tab_pos + 1)
  end

  -- Parse &hotkey
  local hotkey = nil
  local hotkey_col = -1
  local display_text = ""
  local amp_pos = text_part:find("&", 1, true)
  if amp_pos and amp_pos < #text_part then
    hotkey = text_part:sub(amp_pos + 1, amp_pos + 1)
    display_text = text_part:sub(1, amp_pos - 1) .. text_part:sub(amp_pos + 1)
    hotkey_col = amp_pos - 1 -- 0-based byte offset in display_text
  else
    display_text = text_part
  end

  return {
    text = display_text,
    desc = desc_part,
    hotkey = hotkey,
    hotkey_col = hotkey_col,
    is_sep = false,
    enabled = enabled,
    cmd = cmd,
    index = idx,
  }
end

--- Build display lines and compute layout metrics.
---@param items ParsedItem[]
---@return string[] lines
---@return number text_width  max left-side text width
---@return number desc_width  max right-side desc width
local function build_lines(items, cursor_idx)
  -- Compute column widths
  local text_w, desc_w = 0, 0
  for _, item in ipairs(items) do
    if not item.is_sep then
      text_w = math.max(text_w, vim.fn.strdisplaywidth(item.text))
      desc_w = math.max(desc_w, vim.fn.strdisplaywidth(item.desc))
    end
  end

  local gap = desc_w > 0 and 2 or 0
  local stride = text_w + gap + desc_w

  local lines = {}
  for i, item in ipairs(items) do
    if item.is_sep then
      table.insert(lines, " " .. string.rep("─", stride + 2) .. " ")
    else
      local prefix = (i == cursor_idx) and " › " or "   "
      local text_pad = text_w - vim.fn.strdisplaywidth(item.text)
      local line = prefix .. item.text .. string.rep(" ", text_pad)
      if desc_w > 0 then
        local desc_pad = desc_w - vim.fn.strdisplaywidth(item.desc)
        line = line .. "  " .. string.rep(" ", desc_pad) .. item.desc
      end
      line = line .. " "
      table.insert(lines, line)
    end
  end

  return lines, text_w, desc_w
end

--- Apply highlights using extmarks.
---@param buf number
---@param items ParsedItem[]
---@param cursor_idx number 1-based index of cursor item
---@param text_width number
---@param desc_width number
local function apply_highlights(buf, items, cursor_idx, text_width, desc_width)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  local gap = desc_width > 0 and 2 or 0

  for i, item in ipairs(items) do
    local line_idx = i - 1
    local line_text = vim.api.nvim_buf_get_lines(buf, line_idx, line_idx + 1, false)[1] or ""
    local line_len = #line_text

    if item.is_sep then
      -- Separator line
      vim.api.nvim_buf_set_extmark(buf, ns, line_idx, 0, {
        end_row = line_idx,
        end_col = line_len,
        hl_group = "VenuxContextSeparator",
      })
    elseif i == cursor_idx then
      -- Cursor highlight (full line)
      vim.api.nvim_buf_set_extmark(buf, ns, line_idx, 0, {
        end_row = line_idx,
        end_col = line_len,
        hl_group = "VenuxContextCursor",
      })
    else
      if not item.enabled then
        -- Disabled item (full line)
        vim.api.nvim_buf_set_extmark(buf, ns, line_idx, 0, {
          end_row = line_idx,
          end_col = line_len,
          hl_group = "VenuxContextDisabled",
        })
      else
        -- Hotkey underline
        if item.hotkey_col >= 0 then
          local prefix_len = 3 -- "   " or " › "
          local col_start = prefix_len + item.hotkey_col
          local col_end = col_start + #item.hotkey
          if col_end <= line_len then
            vim.api.nvim_buf_set_extmark(buf, ns, line_idx, col_start, {
              end_row = line_idx,
              end_col = col_end,
              hl_group = "VenuxContextHotkey",
            })
          end
        end
        -- Description (right-aligned part)
        if desc_width > 0 and item.desc ~= "" then
          local desc_start = 3 + text_width + gap
          if desc_start < line_len then
            vim.api.nvim_buf_set_extmark(buf, ns, line_idx, desc_start, {
              end_row = line_idx,
              end_col = line_len,
              hl_group = "VenuxContextDesc",
            })
          end
        end
      end
    end
  end
end

--- Find the selectable items (non-separator, enabled).
---@param items ParsedItem[]
---@return number[] 1-based indices of selectable items
local function selectable_indices(items)
  local sel = {}
  for i, item in ipairs(items) do
    if not item.is_sep and item.enabled then
      table.insert(sel, i)
    end
  end
  return sel
end

--- Move cursor among selectable items.
---@param selection number[] selectable indices
---@param current number current 1-based index
---@param direction number -1 for up, 1 for down
---@return number new 1-based index
local function cursor_move(selection, current, direction)
  if #selection == 0 then
    return -1
  end
  -- Find current position in selection list
  local pos = 0
  for i, idx in ipairs(selection) do
    if idx == current then
      pos = i
      break
    end
  end
  if pos == 0 then
    return selection[1]
  end
  local new_pos = pos + direction
  if new_pos < 1 then
    new_pos = #selection
  elseif new_pos > #selection then
    new_pos = 1
  end
  return selection[new_pos]
end

--- Compute window position near cursor, clamped to editor bounds.
---@param w number window width
---@param h number window height
---@return number row, number col (0-based, relative to editor)
local function position_near_cursor(w, h)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local winpos = vim.api.nvim_win_get_position(0)
  local row = winpos[1] + cursor[1]
  local col = winpos[2] + cursor[2]

  -- Clamp to editor bounds (account for border: +2)
  local max_row = vim.o.lines - h - 4
  local max_col = vim.o.columns - w - 3
  if row > max_row then
    row = math.max(0, max_row)
  end
  if col > max_col then
    col = math.max(0, max_col)
  end
  return row, col
end

--- Open a context menu. Blocks via getchar() loop.
---@param items (ContextMenuItem|string)[] Menu item definitions
---@param opts? ContextMenuOpts
---@return number index 0-based index of selected item, or -1 if cancelled
function M.open(items, opts)
  if not items or #items == 0 then
    return -1
  end

  opts = opts or {}
  local title = opts.title
  local border = opts.border or "rounded"
  local position = opts.position or "cursor"
  local ignore_case = opts.ignore_case ~= false

  setup_highlights()

  -- Parse items
  local parsed = {}
  for i, item in ipairs(items) do
    table.insert(parsed, parse_item(item, i - 1))
  end

  -- Build hotkey map
  local hotkeys = {}
  for _, item in ipairs(parsed) do
    if item.enabled and item.hotkey then
      local key = ignore_case and item.hotkey:lower() or item.hotkey
      if not hotkeys[key] then
        hotkeys[key] = item.index + 1 -- 1-based
      end
    end
  end

  -- Find initial cursor position (first selectable item)
  local selection = selectable_indices(parsed)
  if #selection == 0 then
    return -1
  end
  local cursor = selection[1]

  -- Build lines and compute size
  local lines, text_w, desc_w = build_lines(parsed, cursor)
  local max_line_w = 0
  for _, line in ipairs(lines) do
    max_line_w = math.max(max_line_w, vim.fn.strdisplaywidth(line))
  end
  local win_w = max_line_w
  local win_h = #lines

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  -- Compute position
  local row, col
  if position == "center" then
    row = math.floor((vim.o.lines - win_h) / 2)
    col = math.floor((vim.o.columns - win_w) / 2)
  else
    row, col = position_near_cursor(win_w, win_h)
  end

  -- Create float window
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
  vim.wo[win].winhl = "Normal:VenuxContextNormal,FloatBorder:VenuxContextBorder,FloatTitle:VenuxContextTitle"
  vim.wo[win].cursorline = false
  vim.wo[win].wrap = false
  vim.wo[win].scrolloff = 0

  local function render()
    lines, text_w, desc_w = build_lines(parsed, cursor)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    apply_highlights(buf, parsed, cursor, text_w, desc_w)
    vim.api.nvim_win_set_cursor(win, { math.min(cursor, #lines), 0 })
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
    vim.cmd.redraw()
  end

  -- ── Event loop (wrapped in pcall to guarantee cleanup) ──
  local retval = -1

  local loop_ok, loop_err = pcall(function()
    render()

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
        -- Confirm current selection
        if cursor > 0 and cursor <= #parsed then
          local item = parsed[cursor]
          if not item.is_sep and item.enabled then
            retval = item.index
          end
        end
        break
      elseif ch == "j" or ch == "\x80kd" then
        cursor = cursor_move(selection, cursor, 1)
        render()
      elseif ch == "k" or ch == "\x80ku" then
        cursor = cursor_move(selection, cursor, -1)
        render()
      elseif ch == "g" then
        cursor = selection[1]
        render()
      elseif ch == "G" then
        cursor = selection[#selection]
        render()
      else
        -- Check hotkey
        local match_key = ignore_case and ch:lower() or ch
        if hotkeys[match_key] then
          local target = hotkeys[match_key]
          local item = parsed[target]
          if not item.is_sep and item.enabled then
            retval = item.index
          end
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
