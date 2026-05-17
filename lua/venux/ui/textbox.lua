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
-- Created: 2026/05/17 14:53

--- A read-only textbox (pager/viewer) floating window UI component.
--- Displays text content with scrolling, syntax highlighting, line numbers,
--- and "/" incremental search. Press q/Esc/Space/x to close.
---
--- Usage:
---   local textbox = require("venux.ui.textbox")
---   textbox.open(lines, {
---     title = " Preview ",
---     syntax = "lua",
---     number = true,
---   })
---
---   -- Or display shell command output:
---   textbox.command("git log --oneline -20", { title = " Git Log " })

local M = {}

local ns = vim.api.nvim_create_namespace("venux_ui_textbox")

---@class TextboxOpts
---@field title? string              Window title
---@field border? string|string[]    Border style (default: "single")
---@field w? number                  Fixed width (auto-calculated if omitted)
---@field h? number                  Fixed height (auto-calculated if omitted)
---@field max_width? number          Max width ratio 0-1 (default: 0.8)
---@field max_height? number         Max height ratio 0-1 (default: 0.7)
---@field min_width? number          Min width in columns (default: 20)
---@field syntax? string             Filetype for syntax highlighting
---@field number? boolean            Show line numbers (default: false)
---@field wrap? boolean              Wrap long lines (default: true)
---@field index? number              Initial top line, 1-based (default: 1)
---@field cursor? number             Initial cursor line, 1-based (default: -1, no cursorline)

-- Highlight groups
local function setup_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "VenuxTextboxNormal", { link = "NormalFloat", default = true })
  hl(0, "VenuxTextboxBorder", { link = "FloatBorder", default = true })
  hl(0, "VenuxTextboxTitle", { link = "FloatTitle", default = true })
  hl(0, "VenuxTextboxSearch", { link = "Search", default = true })
end

--- Apply search highlights.
---@param buf number
---@param pattern string|nil
local function apply_search_hl(buf, pattern)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
  if not pattern or pattern == "" then
    return
  end
  local ok, regex = pcall(vim.regex, pattern)
  if not ok then
    return
  end
  local line_count = vim.api.nvim_buf_line_count(buf)
  for i = 0, line_count - 1 do
    local line = vim.api.nvim_buf_get_lines(buf, i, i + 1, false)[1] or ""
    local offset = 0
    while offset < #line do
      local s, e = regex:match_str(line:sub(offset + 1))
      if not s then
        break
      end
      vim.api.nvim_buf_set_extmark(buf, ns, i, offset + s, {
        end_row = i,
        end_col = offset + e,
        hl_group = "VenuxTextboxSearch",
      })
      if e == s then
        break -- zero-width match, avoid infinite loop
      end
      offset = offset + e
    end
  end
end

--- Open a textbox viewer. Blocks via getchar() loop.
---@param lines string[]|string Text content (list of lines, or a single string)
---@param opts? TextboxOpts
function M.open(lines, opts)
  if type(lines) == "string" then
    lines = vim.split(lines, "\n", { plain = true })
  end
  if not lines or #lines == 0 then
    return
  end

  opts = opts or {}
  local title = opts.title
  local border = opts.border or "single"
  local max_width = opts.max_width or 0.8
  local max_height = opts.max_height or 0.7
  local min_width = opts.min_width or 20
  local show_wrap = opts.wrap ~= false
  local show_number = opts.number or false
  local init_index = opts.index or 1
  local init_cursor = opts.cursor or -1

  setup_highlights()

  -- Calculate window size
  local max_line_w = 0
  for _, line in ipairs(lines) do
    max_line_w = math.max(max_line_w, vim.fn.strdisplaywidth(line))
  end
  -- Account for line numbers width
  local num_w = 0
  if show_number then
    num_w = #tostring(#lines) + 3
  end

  local max_w = math.floor(vim.o.columns * max_width)
  local max_h = math.floor(vim.o.lines * max_height)

  local win_w = opts.w or math.min(max_line_w + num_w + 2, max_w)
  win_w = math.max(win_w, min_width)
  win_w = math.min(win_w, vim.o.columns - 4)

  local win_h = opts.h or math.min(#lines, max_h)
  win_h = math.max(win_h, 1)
  win_h = math.min(win_h, vim.o.lines - 4)

  -- Create buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  -- Center the window
  local row = math.max(0, math.floor((vim.o.lines - win_h) / 2))
  local col = math.max(0, math.floor((vim.o.columns - win_w) / 2))

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

  vim.wo[win].winhl = "Normal:VenuxTextboxNormal,FloatBorder:VenuxTextboxBorder,FloatTitle:VenuxTextboxTitle"
  vim.wo[win].wrap = show_wrap
  vim.wo[win].scrolloff = 0
  vim.wo[win].signcolumn = "no"
  vim.wo[win].cursorline = true

  if show_number then
    vim.wo[win].number = true
  end

  -- Syntax highlighting
  if opts.syntax then
    vim.bo[buf].filetype = opts.syntax
  end

  -- Initial position
  if init_index > 1 then
    pcall(vim.api.nvim_win_set_cursor, win, { math.min(init_index, #lines), 0 })
  end
  if init_cursor > 0 then
    pcall(vim.api.nvim_win_set_cursor, win, { math.min(init_cursor, #lines), 0 })
  end

  vim.cmd.redraw()

  -- State
  local search_pattern = nil

  local function refresh()
    apply_search_hl(buf, search_pattern)
    vim.cmd.redraw()
  end

  --- Scroll the window.
  ---@param direction string "up"|"down"|"halfup"|"halfdown"|"pageup"|"pagedown"|"top"|"bottom"
  local function scroll(direction)
    if not vim.api.nvim_win_is_valid(win) then
      return
    end
    local cur = vim.api.nvim_win_get_cursor(win)[1]
    local total = #lines
    local new_cur = cur

    if direction == "down" then
      new_cur = math.min(cur + 1, total)
    elseif direction == "up" then
      new_cur = math.max(cur - 1, 1)
    elseif direction == "pagedown" then
      new_cur = math.min(cur + win_h, total)
    elseif direction == "pageup" then
      new_cur = math.max(cur - win_h, 1)
    elseif direction == "halfdown" then
      new_cur = math.min(cur + math.floor(win_h / 2), total)
    elseif direction == "halfup" then
      new_cur = math.max(cur - math.floor(win_h / 2), 1)
    elseif direction == "top" then
      new_cur = 1
    elseif direction == "bottom" then
      new_cur = total
    end

    pcall(vim.api.nvim_win_set_cursor, win, { new_cur, 0 })
    vim.cmd.redraw()
  end

  --- Incremental search.
  ---@return string|nil
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
      vim.api.nvim_echo({ { "/" .. pattern, "Question" } }, false, {})
      search_pattern = #pattern > 0 and pattern or nil
      apply_search_hl(buf, search_pattern)
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
    local cur = vim.api.nvim_win_get_cursor(win)[1]
    local total = #lines
    local i = cur
    for _ = 1, total do
      i = i + direction
      if i < 1 then
        i = total
      elseif i > total then
        i = 1
      end
      local line_text = lines[i] or ""
      if regex:match_str(line_text) then
        pcall(vim.api.nvim_win_set_cursor, win, { i, 0 })
        vim.cmd.redraw()
        return
      end
    end
  end

  --- Cleanup: close window and buffer.
  local function cleanup()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
    vim.api.nvim_echo({ { "", "" } }, false, {})
    vim.cmd.redraw()
  end

  -- ── Event loop (wrapped in pcall to guarantee cleanup) ──
  local loop_ok, loop_err = pcall(function()
    while true do
      local ok, code = pcall(vim.fn.getchar)
      if not ok then
        break
      end

      local ch = type(code) == "number" and vim.fn.nr2char(code) or code
      if ch == "" then
        -- noop
      elseif ch == "\27" or ch == "q" or ch == "x" then
        break
      elseif ch == "\r" or ch == " " then
        break
      elseif ch == "j" or ch == "\x80kd" then
        scroll("down")
      elseif ch == "k" or ch == "\x80ku" then
        scroll("up")
      elseif ch == "g" then
        scroll("top")
      elseif ch == "G" then
        scroll("bottom")
      elseif ch == "\x06" then -- Ctrl-F
        scroll("pagedown")
      elseif ch == "\x02" then -- Ctrl-B
        scroll("pageup")
      elseif ch == "\x04" then -- Ctrl-D
        scroll("halfdown")
      elseif ch == "\x15" then -- Ctrl-U
        scroll("halfup")
      elseif ch == "/" then
        local pat = read_search()
        if pat and pat ~= "" then
          search_pattern = pat
          search_jump(1)
        end
        vim.api.nvim_echo({ { "", "" } }, false, {})
        refresh()
      elseif ch == "n" then
        search_jump(1)
      elseif ch == "N" then
        search_jump(-1)
      end
    end
  end)

  -- Always cleanup, even if the event loop errored
  cleanup()

  -- Re-raise if the loop errored (after cleanup)
  if not loop_ok then
    error(loop_err, 0)
  end
end

--- Run a shell command and display its output in a textbox.
---@param cmd string|string[] Shell command
---@param opts? TextboxOpts
function M.command(cmd, opts)
  local result
  if type(cmd) == "table" then
    result = vim.system(cmd):wait()
  else
    result = vim.system({ "sh", "-c", cmd }):wait()
  end
  local output = (result.stdout or "") .. (result.stderr or "")
  local lines = vim.split(output, "\n", { plain = true })
  -- Trim trailing empty line
  if #lines > 0 and lines[#lines] == "" then
    table.remove(lines)
  end
  M.open(lines, opts)
end

return M
