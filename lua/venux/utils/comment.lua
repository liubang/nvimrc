-- Copyright (c) 2024 The Authors. All rights reserved.
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

local M = {}

M.opts = {
  author = "liubang",
  email = "it.liubang@gmail.com",
}

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

-- stylua: ignore
local prefix_mappings = {
  ["c"]               = "//",
  ["cpp"]             = "//",
  ["rust"]            = "//",
  ["go"]              = "//",
  ["php"]             = "//",
  ["java"]            = "//",
  ["lua"]             = "--",
  ["sql"]             = "--",
  ["vim"]             = '"',
  ["bzl"]             = "#",
  ["python"]          = "#",
  ["sh"]              = "#",
  ["zsh"]             = "#",
  ["bash"]            = "#",
  ["make"]            = "#",
  ["ruby"]            = "#",
  ["javascript"]      = "//",
  ["typescript"]      = "//",
  ["javascriptreact"] = "//",
  ["typescriptreact"] = "//",
}

-- stylua: ignore
local shebang_mappings = {
  ["php"]    = { "<?php" },
  ["sh"]     = { "#! /bin/bash" },
  ["zsh"]    = { "#! /usr/bin/env zsh" },
  ["python"] = { "#! /usr/bin/env python", "# -*- coding: utf-8 -*-" },
}

local function get_filetype()
  return vim.api.nvim_get_option_value("filetype", { buf = 0 })
end

local function get_prefix(ft)
  return prefix_mappings[ft] or "#"
end

local function prepend_shebang(text, ft)
  local shebang = shebang_mappings[ft]
  if shebang then
    for _, line in ipairs(shebang) do
      text[#text + 1] = line
    end
  end
end

function M.add_fileheader()
  local text = {}
  prepend_shebang(text, get_filetype())
  if #text > 0 then
    vim.fn.append(0, text)
  end
end

--- Extracts the `Created:` timestamp value from existing header lines.
--- Returns nil when no Created field is found.
---@param lines string[]
---@return string|nil
local function extract_created(lines)
  for _, line in ipairs(lines) do
    local ts = line:match("Created:%s*(.*)")
    if ts then
      ts = vim.trim(ts)
      if ts ~= "" then
        return ts
      end
    end
  end
  return nil
end

--- Builds the Apache License header lines (without shebang).
---@param c string comment prefix
---@param created_override string|nil preserve this Created timestamp when updating
---@return string[]
local function build_apache_header(c, created_override)
  local now = os.date("*t")
  local year = tostring(now.year)
  local created = created_override
    or string.format("%04d/%02d/%02d %02d:%02d", now.year, now.month, now.day, now.hour, now.min)

  return {
    c .. " Copyright (c) " .. year .. " The Authors. All rights reserved.",
    c,
    c .. ' Licensed under the Apache License, Version 2.0 (the "License");',
    c .. " you may not use this file except in compliance with the License.",
    c .. " You may obtain a copy of the License at",
    c,
    c .. "      https://www.apache.org/licenses/LICENSE-2.0",
    c,
    c .. " Unless required by applicable law or agreed to in writing, software",
    c .. ' distributed under the License is distributed on an "AS IS" BASIS,',
    c .. " WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.",
    c .. " See the License for the specific language governing permissions and",
    c .. " limitations under the License.",
    "",
    string.format("%s Authors: %s (%s)", c, M.opts.author, M.opts.email),
    string.format("%s Created: %s", c, created),
    "",
  }
end

---Returns true if `line` is blank or starts with the comment prefix `p`.
---@param line string
---@param p string
---@return boolean
local function is_comment_or_blank(line, p)
  local trimmed = vim.trim(line)
  if trimmed == "" then
    return true
  end
  if p ~= "" then
    return trimmed:find("^" .. vim.pesc(p)) ~= nil
  end
  return false
end

---Inserts or updates the Apache 2.0 License header at the top of the current buffer.
---
---If a header already exists (detected via the "Copyright (c)" anchor), it is replaced
---in-place. User comments above the header (separated by a non-blank line) are preserved.
---Only contiguous blank lines preceding the header are included in the replacement range.
function M.copy_right_apache()
  local ft = get_filetype()
  local c = get_prefix(ft)
  local buf = 0

  -- Scan a generous prefix of the file to detect an existing header
  local total = vim.api.nvim_buf_line_count(buf)
  local scan = math.min(100, total)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, scan, true)

  local has_shebang = #lines > 0 and lines[1]:match("^#!")

  -- Locate anchor: "Copyright (c)" — unique enough to identify a generated header
  local anchor -- 1-indexed line number
  for i = 1, #lines do
    if lines[i]:find("Copyright %(c%)") then
      anchor = i
      break
    end
  end

  if anchor then
    -- ── Existing header found: compute replacement range ──────────────────
    --
    -- Backward: walk up from the anchor, include only blank lines.
    -- Stop at the first non-blank line (shebang, code, or user comment).
    local head_start = anchor
    while head_start > 1 do
      if vim.trim(lines[head_start - 1]) == "" then
        head_start = head_start - 1
      else
        break
      end
    end

    -- Forward: walk down from the anchor, include contiguous
    -- comment / blank lines until we hit real code.
    local head_end = anchor
    while head_end <= #lines do
      if is_comment_or_blank(lines[head_end], c) then
        head_end = head_end + 1
      else
        break
      end
    end

    -- Extract old Created timestamp from the existing header block
    -- so we preserve the original creation time across updates.
    local old_created = nil
    for i = head_start, head_end do
      old_created = extract_created({ lines[i] })
      if old_created then
        break
      end
    end

    -- Build replacement header (without duplicating an existing shebang)
    local new_header = {}
    if not has_shebang then
      prepend_shebang(new_header, ft)
    end
    vim.list_extend(new_header, build_apache_header(c, old_created))

    -- Replace old header block in-place (0-indexed, end-exclusive)
    vim.api.nvim_buf_set_lines(buf, head_start - 1, head_end - 1, true, new_header)
    vim.notify("Apache header updated.", vim.log.levels.INFO)
  else
    -- ── No existing header: insert after shebang or at file start ─────────
    local new_header = {}
    if not has_shebang then
      prepend_shebang(new_header, ft)
    end
    vim.list_extend(new_header, build_apache_header(c))

    local insert_at = has_shebang and 1 or 0
    vim.api.nvim_buf_set_lines(buf, insert_at, insert_at, true, new_header)
    vim.notify("Apache header added.", vim.log.levels.INFO)
  end
end

return M
