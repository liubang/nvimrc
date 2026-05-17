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
-- Created: 2026/05/17 00:43

--- A checkbox-based multi-select floating window UI component.
--- Uses Neovim native float + scratch buffer + getchar() event loop.
---
--- Usage:
---   local multi_select = require("venux.ui.multi_select")
---   local selected = multi_select.open("Pick items:", items, {
---     format_item = tostring,
---     title = " My Picker ",
---     default_checked = true,
---   })

local M = {}

local ns = vim.api.nvim_create_namespace("venux_ui_multi_select")

---@class MultiSelectOpts
---@field format_item? fun(item: any): string  Display formatter
---@field title? string                        Window title (default: " Select ")
---@field default_checked? boolean             Initial check state (default: true)
---@field border? string|string[]              Border style (default: "single")
---@field min_width? number                    Minimum width ratio 0-1 (default: 0.35)
---@field max_width? number                    Maximum width ratio 0-1 (default: 0.6)
---@field max_height? number                   Maximum height ratio 0-1 (default: 0.8)

-- Highlight groups (linked to standard groups, auto-adapts to colorscheme)
local function setup_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "VenuxMultiSelectNormal", { link = "NormalFloat", default = true })
  hl(0, "VenuxMultiSelectBorder", { link = "FloatBorder", default = true })
  hl(0, "VenuxMultiSelectTitle", { link = "FloatTitle", default = true })
  hl(0, "VenuxMultiSelectCursor", { link = "PmenuSel", default = true })
  hl(0, "VenuxMultiSelectChecked", { link = "String", default = true })
  hl(0, "VenuxMultiSelectUnchecked", { link = "Comment", default = true })
  hl(0, "VenuxMultiSelectFooter", { link = "Comment", default = true })
end

--- Build display lines.
---@param prompt string
---@param labels string[]
---@param checked boolean[]
---@param cursor number 1-based
---@return string[] lines, number content_start (1-based line index of first checkbox)
local function build_lines(prompt, labels, checked, cursor)
  local lines = {}
  for line in prompt:gmatch("[^\n]+") do
    table.insert(lines, " " .. line)
  end
  table.insert(lines, "")
  local content_start = #lines + 1
  for i, label in ipairs(labels) do
    local mark = checked[i] and "[x]" or "[ ]"
    local prefix = (i == cursor) and " > " or "   "
    table.insert(lines, prefix .. mark .. " " .. label)
  end
  table.insert(lines, "")
  table.insert(lines, " <Space> toggle  <a> all  <n> none  <CR> confirm  <q/Esc> cancel")
  return lines, content_start
end

--- Apply highlights to the buffer using extmarks.
---@param buf number
---@param labels string[]
---@param checked boolean[]
---@param cursor number 1-based
---@param content_start number 1-based
local function apply_highlights(buf, labels, checked, cursor, content_start)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  for i = 1, #labels do
    local line_idx = content_start - 1 + (i - 1)
    if i == cursor then
      vim.api.nvim_buf_set_extmark(buf, ns, line_idx, 0, {
        end_row = line_idx,
        end_col = #vim.api.nvim_buf_get_lines(buf, line_idx, line_idx + 1, false)[1],
        hl_group = "VenuxMultiSelectCursor",
      })
    elseif checked[i] then
      vim.api.nvim_buf_set_extmark(buf, ns, line_idx, 3, {
        end_row = line_idx,
        end_col = 6,
        hl_group = "VenuxMultiSelectChecked",
      })
    else
      vim.api.nvim_buf_set_extmark(buf, ns, line_idx, 3, {
        end_row = line_idx,
        end_col = 6,
        hl_group = "VenuxMultiSelectUnchecked",
      })
    end
  end
  local total_lines = vim.api.nvim_buf_line_count(buf)
  local last_line = vim.api.nvim_buf_get_lines(buf, total_lines - 1, total_lines, false)[1]
  vim.api.nvim_buf_set_extmark(buf, ns, total_lines - 1, 0, {
    end_row = total_lines - 1,
    end_col = #last_line,
    hl_group = "VenuxMultiSelectFooter",
  })
end

--- Open a multi-select dialog. Blocks via getchar() loop.
---@param prompt string Prompt text shown above the items
---@param values any[] The values to select from
---@param opts? MultiSelectOpts
---@return any[]|nil Selected values, or nil if cancelled
function M.open(prompt, values, opts)
  if #values == 0 then
    return nil
  end

  opts = opts or {}
  local format_item = opts.format_item
  local title = opts.title or " Select "
  local default_checked = opts.default_checked ~= false
  local border = opts.border or "single"
  local min_width = opts.min_width or 0.35
  local max_width = opts.max_width or 0.6
  local max_height = opts.max_height or 0.8

  setup_highlights()

  -- State
  local labels = {}
  for _, v in ipairs(values) do
    table.insert(labels, format_item and format_item(v) or tostring(v))
  end
  local checked = {}
  for i = 1, #values do
    checked[i] = default_checked
  end
  local cursor = 1

  -- Calculate window size
  local max_label_w = 0
  for _, l in ipairs(labels) do
    max_label_w = math.max(max_label_w, vim.fn.strdisplaywidth(l))
  end
  local footer_w = vim.fn.strdisplaywidth(" <Space> toggle  <a> all  <n> none  <CR> confirm  <q/Esc> cancel")
  local content_w = math.max(max_label_w + 8, vim.fn.strdisplaywidth(" " .. prompt) + 2, footer_w + 2)
  local win_w = math.max(content_w, math.floor(vim.o.columns * min_width))
  win_w = math.min(win_w, math.floor(vim.o.columns * max_width))

  local lines, content_start = build_lines(prompt, labels, checked, cursor)
  local win_h = math.min(#lines, math.floor(vim.o.lines * max_height))

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  -- Create float window (centered)
  local row = math.floor((vim.o.lines - win_h) / 2)
  local col = math.floor((vim.o.columns - win_w) / 2)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = win_w,
    height = win_h,
    style = "minimal",
    border = border,
    title = title,
    title_pos = "center",
    noautocmd = true,
  })

  vim.wo[win].winhl =
    "Normal:VenuxMultiSelectNormal,FloatBorder:VenuxMultiSelectBorder,FloatTitle:VenuxMultiSelectTitle"
  vim.wo[win].cursorline = false
  vim.wo[win].wrap = false
  vim.wo[win].scrolloff = 0

  local function render()
    lines, content_start = build_lines(prompt, labels, checked, cursor)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    apply_highlights(buf, labels, checked, cursor, content_start)
    local cursor_line = content_start + cursor - 1
    vim.api.nvim_win_set_cursor(win, { math.min(cursor_line, #lines), 0 })
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
  local cancelled = false

  local loop_ok, loop_err = pcall(function()
    render()

    while true do
      local ok, code = pcall(vim.fn.getchar)
      if not ok then
        cancelled = true
        break
      end

      local ch = type(code) == "number" and vim.fn.nr2char(code) or code
      if ch == "" then
        -- noop
      elseif ch == "\27" or ch == "q" then
        cancelled = true
        break
      elseif ch == "\r" then
        break
      elseif ch == " " then
        checked[cursor] = not checked[cursor]
        render()
      elseif ch == "j" or ch == "\x80kd" then
        cursor = cursor < #labels and cursor + 1 or 1
        render()
      elseif ch == "k" or ch == "\x80ku" then
        cursor = cursor > 1 and cursor - 1 or #labels
        render()
      elseif ch == "a" then
        for i = 1, #checked do
          checked[i] = true
        end
        render()
      elseif ch == "n" then
        for i = 1, #checked do
          checked[i] = false
        end
        render()
      elseif ch == "g" then
        cursor = 1
        render()
      elseif ch == "G" then
        cursor = #labels
        render()
      end
    end
  end)

  -- Always cleanup, even if the event loop errored
  cleanup()

  -- Re-raise if the loop errored (after cleanup)
  if not loop_ok then
    error(loop_err, 0)
  end

  if cancelled then
    return nil
  end

  local selected = {}
  for i, v in ipairs(values) do
    if checked[i] then
      table.insert(selected, v)
    end
  end
  return #selected > 0 and selected or nil
end

return M
