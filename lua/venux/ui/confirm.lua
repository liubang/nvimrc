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
-- Created: 2026/05/17 15:26

--- A confirm dialog floating window UI component.
--- Displays a prompt message with a row of buttons. The user can navigate
--- between buttons with Left/Right/h/l/Tab and confirm with Enter/Space.
--- Hotkeys (marked with "&" in button text) provide single-key selection.
---
--- Inspired by vim-quickui's confirm.vim.
---
--- Usage:
---   local confirm = require("venux.ui.confirm")
---   local choice = confirm.open("Save changes before closing?", {
---     choices = { "&Yes", "&No", "&Cancel" },
---     title = " Confirm ",
---   })
---   -- choice is 1-based button index, or 0 if cancelled

local M = {}

local ns = vim.api.nvim_create_namespace("venux_ui_confirm")

---@class ConfirmOpts
---@field choices? string[]|string   Button labels; "&" marks hotkey (default: { "&OK" })
---@field title? string              Window title (default: " Confirm ")
---@field border? string|string[]    Border style (default: "rounded")
---@field default? number            1-based index of initially focused button (default: 1)

-- ════════════════════════════════════════════════════════════════════
-- Highlight groups
-- ════════════════════════════════════════════════════════════════════

local function setup_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "VenuxConfirmNormal", { link = "NormalFloat", default = true })
  hl(0, "VenuxConfirmBorder", { link = "FloatBorder", default = true })
  hl(0, "VenuxConfirmTitle", { link = "FloatTitle", default = true })
  hl(0, "VenuxConfirmPrompt", { link = "Question", default = true })
  hl(0, "VenuxConfirmButtonOn", { link = "PmenuSel", default = true })
  hl(0, "VenuxConfirmButtonOff", { link = "NormalFloat", default = true })
  -- VenuxConfirmHotkeyOn: PmenuSel colors + underline (link ignores extra attrs)
  local psel = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
  hl(
    0,
    "VenuxConfirmHotkeyOn",
    vim.tbl_extend("force", {
      fg = psel.fg,
      bg = psel.bg,
      underline = true,
      default = true,
    }, {})
  )
  hl(0, "VenuxConfirmHotkeyOff", { link = "Underlined", default = true })
end

-- ════════════════════════════════════════════════════════════════════
-- Button parsing
-- ════════════════════════════════════════════════════════════════════

---@class ParsedButton
---@field text string          Display text (without "&")
---@field text_width number    Display width of text
---@field hotkey string|nil    The hotkey character (lowercase)
---@field hotkey_col number    Byte offset of hotkey in text (-1 if none)
---@field index number         1-based button index

--- Parse a single button label like "&Yes" → { text = "Yes", hotkey = "y", hotkey_col = 0 }
---@param label string
---@param idx number 1-based
---@return ParsedButton
local function parse_button(label, idx)
  local text = label
  local hotkey = nil
  local hotkey_col = -1

  local amp = label:find("&", 1, true)
  if amp and amp < #label then
    local before = label:sub(1, amp - 1)
    local after = label:sub(amp + 1)
    text = before .. after
    hotkey = after:sub(1, 1):lower()
    hotkey_col = #before -- byte offset in display text
  end

  return {
    text = text,
    text_width = vim.fn.strdisplaywidth(text),
    hotkey = hotkey,
    hotkey_col = hotkey_col,
    index = idx,
  }
end

--- Parse all button labels and equalize their widths.
---@param choices string[]
---@return ParsedButton[]
local function parse_buttons(choices)
  local buttons = {}
  local max_w = 4 -- minimum button text width
  for i, label in ipairs(choices) do
    local btn = parse_button(label, i)
    max_w = math.max(max_w, btn.text_width)
    table.insert(buttons, btn)
  end

  -- Pad all buttons to equal width (centered text)
  for _, btn in ipairs(buttons) do
    local pad_total = max_w - btn.text_width
    local pad_left = math.floor(pad_total / 2)
    local pad_right = pad_total - pad_left
    if btn.hotkey_col >= 0 then
      -- Shift hotkey_col by left padding bytes
      btn.hotkey_col = btn.hotkey_col + pad_left
    end
    btn.text = string.rep(" ", pad_left) .. btn.text .. string.rep(" ", pad_right)
    btn.text_width = vim.fn.strdisplaywidth(btn.text)
  end

  return buttons
end

--- Build the button line string and compute per-button byte ranges.
--- Each button is rendered as "<text>" with 2-space gaps between them.
---@param buttons ParsedButton[]
---@return string line
---@return table[] ranges  { start: byte, stop: byte, hotkey_byte: byte|nil } per button
local function build_button_line(buttons)
  local parts = {}
  local ranges = {}
  local pos = 0

  for i, btn in ipairs(buttons) do
    local display = "<" .. btn.text .. ">"
    local display_bytes = #display
    table.insert(parts, display)

    local hotkey_byte = nil
    if btn.hotkey_col >= 0 then
      -- +1 for the leading "<"
      hotkey_byte = pos + 1 + btn.hotkey_col
    end

    table.insert(ranges, {
      start = pos,
      stop = pos + display_bytes,
      hotkey_byte = hotkey_byte,
    })

    pos = pos + display_bytes
    if i < #buttons then
      table.insert(parts, "  ")
      pos = pos + 2
    end
  end

  return table.concat(parts), ranges
end

-- ════════════════════════════════════════════════════════════════════
-- Main entry
-- ════════════════════════════════════════════════════════════════════

--- Open a confirm dialog. Blocks via getchar() loop.
---@param prompt string|string[] Prompt text shown above the buttons
---@param opts? ConfirmOpts
---@return number choice 1-based index of selected button, or 0 if cancelled
function M.open(prompt, opts)
  opts = opts or {}
  local title = opts.title or " Confirm "
  local border = opts.border or "rounded"
  local default_idx = opts.default or 1

  setup_highlights()

  -- Parse choices
  local raw_choices = opts.choices or { "&OK" }
  if type(raw_choices) == "string" then
    -- Split by "|" for vim-confirm style: "&Yes|&No|&Cancel"
    local list = {}
    for part in raw_choices:gmatch("[^|]+") do
      table.insert(list, vim.trim(part))
    end
    raw_choices = list
  end

  local buttons = parse_buttons(raw_choices)
  if #buttons == 0 then
    return 0
  end

  -- Build hotkey map: lowercase char → 1-based button index
  local hotkeys = {}
  for _, btn in ipairs(buttons) do
    if btn.hotkey and not hotkeys[btn.hotkey] then
      hotkeys[btn.hotkey] = btn.index
    end
  end

  -- Parse prompt lines
  local prompt_lines = {}
  if type(prompt) == "table" then
    for _, line in ipairs(prompt) do
      table.insert(prompt_lines, line)
    end
  else
    for line in tostring(prompt):gmatch("[^\n]+") do
      table.insert(prompt_lines, line)
    end
  end

  -- Build button line
  local btn_line, btn_ranges = build_button_line(buttons)
  local btn_line_w = vim.fn.strdisplaywidth(btn_line)

  -- Calculate window width
  local content_w = 8
  for _, line in ipairs(prompt_lines) do
    content_w = math.max(content_w, vim.fn.strdisplaywidth(line))
  end
  content_w = math.max(content_w, btn_line_w)
  local win_w = math.max(content_w + 4, 30) -- 2 padding each side
  win_w = math.min(win_w, vim.o.columns - 4)
  win_w = math.max(win_w, 20)

  -- Window height: prompt lines + blank line + button line
  local win_h = #prompt_lines + 2

  -- Current focused button (1-based)
  local focus = math.max(1, math.min(default_idx, #buttons))

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"

  -- Center the window
  local row = math.max(0, math.floor((vim.o.lines - win_h) / 2))
  local col = math.max(0, math.floor((vim.o.columns - win_w) / 2))

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
  vim.wo[win].winhl = "Normal:VenuxConfirmNormal,FloatBorder:VenuxConfirmBorder,FloatTitle:VenuxConfirmTitle"
  vim.wo[win].cursorline = false
  vim.wo[win].wrap = false
  vim.wo[win].scrolloff = 0

  -- Center the button line within the window
  local btn_padding = math.max(0, math.floor((win_w - btn_line_w) / 2))

  --- Render the confirm dialog.
  local function render()
    -- Build buffer lines
    local lines = {}
    for _, pl in ipairs(prompt_lines) do
      table.insert(lines, " " .. pl)
    end
    table.insert(lines, "") -- blank separator
    table.insert(lines, string.rep(" ", btn_padding) .. btn_line)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Apply highlights
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    -- Prompt lines
    for i = 1, #prompt_lines do
      vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
        end_row = i - 1,
        end_col = #lines[i],
        hl_group = "VenuxConfirmPrompt",
      })
    end

    -- Button highlights
    local btn_row = #prompt_lines + 1 -- 0-based line index
    for i, rng in ipairs(btn_ranges) do
      local base = btn_padding
      local is_focused = (i == focus)

      if rng.hotkey_byte then
        -- Three regions: before hotkey, hotkey, after hotkey
        local hk_start = base + rng.hotkey_byte
        local hk_end = hk_start + 1 -- hotkey is always 1 ASCII byte

        -- Before hotkey
        if hk_start > base + rng.start then
          vim.api.nvim_buf_set_extmark(buf, ns, btn_row, base + rng.start, {
            end_row = btn_row,
            end_col = hk_start,
            hl_group = is_focused and "VenuxConfirmButtonOn" or "VenuxConfirmButtonOff",
          })
        end

        -- Hotkey character (underlined)
        vim.api.nvim_buf_set_extmark(buf, ns, btn_row, hk_start, {
          end_row = btn_row,
          end_col = hk_end,
          hl_group = is_focused and "VenuxConfirmHotkeyOn" or "VenuxConfirmHotkeyOff",
        })

        -- After hotkey
        if hk_end < base + rng.stop then
          vim.api.nvim_buf_set_extmark(buf, ns, btn_row, hk_end, {
            end_row = btn_row,
            end_col = base + rng.stop,
            hl_group = is_focused and "VenuxConfirmButtonOn" or "VenuxConfirmButtonOff",
          })
        end
      else
        -- No hotkey: single region for entire button
        vim.api.nvim_buf_set_extmark(buf, ns, btn_row, base + rng.start, {
          end_row = btn_row,
          end_col = base + rng.stop,
          hl_group = is_focused and "VenuxConfirmButtonOn" or "VenuxConfirmButtonOff",
        })
      end
    end

    -- Place cursor on the button row to keep it out of the prompt area
    pcall(vim.api.nvim_win_set_cursor, win, { btn_row + 1, 0 })
    vim.cmd.redraw()
  end

  --- Cleanup: restore window/buffer.
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
  local result = 0

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
      elseif ch == "\27" or ch == "\x03" then
        -- Esc / Ctrl-C: cancel
        break
      elseif ch == "\r" or ch == " " then
        -- Enter / Space: confirm focused button
        result = focus
        break
      elseif ch == "\x80kl" or ch == "h" or ch == "\x80\xfcH" then
        -- Left / h / Shift-Tab
        focus = focus > 1 and focus - 1 or #buttons
        render()
      elseif ch == "\x80kr" or ch == "l" or ch == "\t" then
        -- Right / l / Tab
        focus = focus < #buttons and focus + 1 or 1
        render()
      elseif ch == "\x80kh" or ch == "\x01" then
        -- Home / Ctrl-A
        focus = 1
        render()
      elseif ch == "\x80@7" or ch == "\x05" then
        -- End / Ctrl-E
        focus = #buttons
        render()
      else
        -- Check hotkey
        local lower = ch:lower()
        if hotkeys[lower] then
          -- Brief visual feedback: focus the button, render, then return
          focus = hotkeys[lower]
          result = focus
          render()
          vim.cmd("sleep 80m")
          break
        end
      end
    end
  end)

  -- Always cleanup
  cleanup()

  -- Re-raise if the loop errored (after cleanup)
  if not loop_ok then
    error(loop_err, 0)
  end

  return result
end

return M
