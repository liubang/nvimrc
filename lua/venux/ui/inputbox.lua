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
-- Created: 2026/05/17 14:58

--- An input box floating window UI component.
--- Uses a single float window with getchar() blocking loop (consistent with
--- other venux.ui components). The cursor is rendered via a reverse-video
--- extmark on the input line.
---
--- Inspired by vim-quickui's input.vim.
---
--- Usage:
---   local inputbox = require("venux.ui.inputbox")
---   local result = inputbox.open("Enter your name:", {
---     title = " Input ",
---     text = "default value",
---   })
---   -- result is the entered string, or nil if cancelled

local M = {}

local ns = vim.api.nvim_create_namespace("venux_ui_inputbox")

---@class InputboxOpts
---@field title? string              Window title (default: " Input ")
---@field border? string|string[]    Border style (default: "single")
---@field text? string               Default text in the input field
---@field w? number                  Fixed width (auto-calculated if omitted)
---@field history? string            History key for persistent history across calls
---@field strict? boolean            If true, empty input returns nil (default: true)

-- Highlight groups
local function setup_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "VenuxInputNormal", { link = "NormalFloat", default = true })
  hl(0, "VenuxInputBorder", { link = "FloatBorder", default = true })
  hl(0, "VenuxInputTitle", { link = "FloatTitle", default = true })
  hl(0, "VenuxInputPrompt", { link = "Question", default = true })
  -- Cursor: reverse video block — works reliably across colorschemes
  hl(0, "VenuxInputCursor", { reverse = true, default = true })
end

-- ════════════════════════════════════════════════════════════════════
-- Minimal readline using vim.fn for UTF-8 string operations
-- ════════════════════════════════════════════════════════════════════

---@class Readline
---@field text string
---@field cursor number  0-based character position

local function rl_new(text)
  return { text = text or "", cursor = vim.fn.strchars(text or "") }
end

local function rl_len(rl)
  return vim.fn.strchars(rl.text)
end

local function rl_move(rl, pos)
  rl.cursor = math.max(0, math.min(pos, rl_len(rl)))
end

local function rl_insert(rl, s)
  local before = vim.fn.strcharpart(rl.text, 0, rl.cursor)
  local after = vim.fn.strcharpart(rl.text, rl.cursor)
  rl.text = before .. s .. after
  rl.cursor = rl.cursor + vim.fn.strchars(s)
end

local function rl_delete(rl, n)
  local len = rl_len(rl)
  n = math.min(n, len - rl.cursor)
  if n > 0 then
    local before = vim.fn.strcharpart(rl.text, 0, rl.cursor)
    local after = vim.fn.strcharpart(rl.text, rl.cursor + n)
    rl.text = before .. after
  end
end

local function rl_backspace(rl, n)
  n = math.min(n, rl.cursor)
  if n > 0 then
    rl.cursor = rl.cursor - n
    rl_delete(rl, n)
  end
end

-- ════════════════════════════════════════════════════════════════════
-- History (module-level, persists across calls within a session)
-- ════════════════════════════════════════════════════════════════════

local history_store = {}

-- ════════════════════════════════════════════════════════════════════
-- Inputbox UI
-- ════════════════════════════════════════════════════════════════════

--- Open an input box. Blocks via getchar() loop.
---@param prompt string|string[] Prompt text shown above the input field
---@param opts? InputboxOpts
---@return string|nil The entered text, or nil if cancelled
function M.open(prompt, opts)
  opts = opts or {}
  local title = opts.title or " Input "
  local border = opts.border or "single"
  local default_text = opts.text or ""
  local strict = opts.strict ~= false
  local history_key = opts.history

  setup_highlights()

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

  -- Calculate width
  local content_w = 8
  for _, line in ipairs(prompt_lines) do
    content_w = math.max(content_w, vim.fn.strdisplaywidth(line))
  end
  local win_w = opts.w or math.max(content_w + 4, 50)
  win_w = math.min(win_w, vim.o.columns - 4)
  win_w = math.max(win_w, 20)

  -- Input field display width (1 padding each side)
  local field_w = win_w - 2

  -- Window height: prompt lines + separator + input line
  local win_h = #prompt_lines + 2

  -- Initialize readline
  local rl = rl_new(default_text)

  -- History
  local hist_list = {}
  local hist_idx = 0
  if history_key then
    hist_list = { rl.text }
    for _, h in ipairs(history_store[history_key] or {}) do
      table.insert(hist_list, h)
    end
    hist_idx = 1
  end

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
  vim.wo[win].winhl = "Normal:VenuxInputNormal,FloatBorder:VenuxInputBorder,FloatTitle:VenuxInputTitle"
  vim.wo[win].cursorline = false
  vim.wo[win].wrap = false
  vim.wo[win].scrolloff = 0

  -- Hide the real Neovim cursor while the inputbox is open
  local saved_guicursor = vim.o.guicursor
  vim.o.guicursor = "a:VenuxInputHiddenCursor"
  -- Create a fully transparent cursor highlight
  vim.api.nvim_set_hl(0, "VenuxInputHiddenCursor", { blend = 100, nocombine = true })

  -- Viewport for horizontal scrolling
  local view_pos = 0

  --- Slide viewport so cursor is visible within field_w columns.
  local function slide_viewport()
    local len = rl_len(rl)
    if rl.cursor < view_pos then
      view_pos = rl.cursor
      return
    end
    -- Calculate display width from view_pos to cursor (inclusive)
    local width = 0
    for i = view_pos, rl.cursor do
      local ch = i < len and vim.fn.strcharpart(rl.text, i, 1) or " "
      width = width + vim.fn.strdisplaywidth(ch)
    end
    if width <= field_w then
      return
    end
    -- Scroll: find new start
    local sum = 0
    local p = rl.cursor
    while p >= 0 do
      local ch = p < len and vim.fn.strcharpart(rl.text, p, 1) or " "
      local w = vim.fn.strdisplaywidth(ch)
      if sum + w > field_w then
        break
      end
      sum = sum + w
      p = p - 1
    end
    view_pos = math.max(0, p + 1)
  end

  --- Build the visible portion of the input text and cursor byte offset.
  ---@return string display_text, number cursor_byte_start, number cursor_byte_end
  local function build_input_display()
    local len = rl_len(rl)
    -- How many chars fit from view_pos
    local sum = 0
    local nchars = 0
    local i = view_pos
    while i < len do
      local ch = vim.fn.strcharpart(rl.text, i, 1)
      local w = vim.fn.strdisplaywidth(ch)
      if sum + w > field_w then
        break
      end
      sum = sum + w
      nchars = nchars + 1
      i = i + 1
    end

    local visible = vim.fn.strcharpart(rl.text, view_pos, nchars)
    -- Pad to field_w
    local pad = field_w - vim.fn.strdisplaywidth(visible)
    -- If cursor is at end of text and beyond visible, add a space for cursor
    local display = visible .. string.rep(" ", math.max(0, pad))

    -- Calculate cursor byte offset within the display string
    -- Cursor is at character position (rl.cursor - view_pos) within visible
    local cursor_char_offset = rl.cursor - view_pos
    local before_cursor = vim.fn.strcharpart(display, 0, cursor_char_offset)
    local at_cursor = vim.fn.strcharpart(display, cursor_char_offset, 1)
    local cursor_byte_start = #before_cursor
    local cursor_byte_end = cursor_byte_start + #at_cursor

    return display, cursor_byte_start, cursor_byte_end
  end

  --- Render the entire inputbox.
  local function render()
    slide_viewport()

    local display, cur_start, cur_end = build_input_display()

    -- Build buffer lines
    local lines = {}
    for _, pl in ipairs(prompt_lines) do
      table.insert(lines, " " .. pl)
    end
    table.insert(lines, "") -- separator line
    table.insert(lines, " " .. display)

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Apply highlights
    vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

    -- Prompt lines
    for i = 1, #prompt_lines do
      vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, {
        end_row = i - 1,
        end_col = #lines[i],
        hl_group = "VenuxInputPrompt",
      })
    end

    -- Cursor highlight on the input line (reverse video block)
    local input_line_idx = #prompt_lines + 1 -- 0-based
    local byte_offset = 1 -- leading " "
    vim.api.nvim_buf_set_extmark(buf, ns, input_line_idx, byte_offset + cur_start, {
      end_row = input_line_idx,
      end_col = byte_offset + cur_end,
      hl_group = "VenuxInputCursor",
    })

    -- Move real cursor to the input line (even though it's hidden, this
    -- prevents it from appearing at line 1 col 1 on some terminals)
    pcall(vim.api.nvim_win_set_cursor, win, { input_line_idx + 1, byte_offset + cur_start })

    vim.cmd.redraw()
  end

  --- Cleanup: restore guicursor and close window/buffer.
  --- This MUST run no matter how the event loop exits.
  local function cleanup()
    vim.o.guicursor = saved_guicursor
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
    vim.cmd.redraw()
  end

  -- ── Event loop (wrapped in pcall to guarantee cleanup) ──
  local result = nil

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
      elseif ch == "\r" then
        -- Enter: confirm
        local text = rl.text
        if text ~= "" or not strict then
          result = text
        end
        break
      elseif ch == "\x80ku" or ch == "\x10" then
        -- Up / Ctrl-P: history prev
        if #hist_list > 0 then
          hist_list[hist_idx] = rl.text
          hist_idx = hist_idx < #hist_list and hist_idx + 1 or 1
          rl.text = hist_list[hist_idx] or ""
          rl_move(rl, rl_len(rl))
          render()
        end
      elseif ch == "\x80kd" or ch == "\x0e" then
        -- Down / Ctrl-N: history next
        if #hist_list > 0 then
          hist_list[hist_idx] = rl.text
          hist_idx = hist_idx > 1 and hist_idx - 1 or #hist_list
          rl.text = hist_list[hist_idx] or ""
          rl_move(rl, rl_len(rl))
          render()
        end
      elseif ch == "\b" or ch == "\127" or ch == "\x80kb" then
        -- Backspace
        rl_backspace(rl, 1)
        render()
      elseif ch == "\x80kD" or ch == "\x04" then
        -- Delete / Ctrl-D
        rl_delete(rl, 1)
        render()
      elseif ch == "\x80kl" or ch == "\x02" then
        -- Left / Ctrl-B
        rl_move(rl, rl.cursor - 1)
        render()
      elseif ch == "\x80kr" or ch == "\x06" then
        -- Right / Ctrl-F
        rl_move(rl, rl.cursor + 1)
        render()
      elseif ch == "\x80kh" or ch == "\x01" then
        -- Home / Ctrl-A
        rl_move(rl, 0)
        render()
      elseif ch == "\x80@7" or ch == "\x05" then
        -- End / Ctrl-E
        rl_move(rl, rl_len(rl))
        render()
      elseif ch == "\x0b" then
        -- Ctrl-K: kill to end
        rl_delete(rl, rl_len(rl) - rl.cursor)
        render()
      elseif ch == "\x15" then
        -- Ctrl-U: kill to beginning
        rl_backspace(rl, rl.cursor)
        render()
      elseif ch == "\x17" then
        -- Ctrl-W: delete word backward (UTF-8 safe via vim regex)
        local before = vim.fn.strcharpart(rl.text, 0, rl.cursor)
        -- Use vim's regex for proper multi-byte word boundary detection
        local trimmed = vim.fn.substitute(before, "\\s\\+$", "", "")
        local word_start = vim.fn.match(trimmed, "\\k\\+$")
        local delete_count
        if word_start >= 0 then
          delete_count = vim.fn.strchars(before) - word_start
        else
          -- No keyword chars found; delete trailing whitespace only
          delete_count = vim.fn.strchars(before) - vim.fn.strchars(trimmed)
        end
        if delete_count > 0 then
          rl_backspace(rl, delete_count)
        end
        render()
      else
        -- Printable character
        local byte = ch:byte(1)
        if byte and byte >= 0x20 and byte ~= 0x7f then
          rl_insert(rl, ch)
          render()
        end
      end
    end
  end)

  -- Always cleanup, even if the event loop errored
  cleanup()

  -- Save history
  if history_key and result then
    local save = { result }
    for _, h in ipairs(history_store[history_key] or {}) do
      if h ~= result and #save < 50 then
        table.insert(save, h)
      end
    end
    history_store[history_key] = save
  end

  return result
end

return M
