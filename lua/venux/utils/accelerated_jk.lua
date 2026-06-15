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
-- Created: 2026/06/15 23:23

-- accelerated_jk.lua — hold j/k to accelerate cursor movement
--
-- Architecture
--   Accelerator  — pure algorithm: time-driven step counter (no Neovim dep)
--   bind()       — bridges Accelerator ↔ Neovim expr keymap
--   setup()      — public entry point, composes the two above
--
-- Usage
--   require("venux.accelerated_jk").setup({
--     acceleration_limit = 150,
--     acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
--   })

local M = {}

-- ===========================================================================
-- Defaults
-- ===========================================================================

local defaults = {
  acceleration_limit = 150,
  acceleration_table = { 5, 10, 14, 18, 21, 24, 26, 28 },
}

-- ===========================================================================
-- Accelerator — encapsulates state & logic for a single direction
-- ===========================================================================

---@class Accelerator
---@field advance fun(now: number): integer  return line count for this step
---@field reset   fun()                       reset to idle (step = 0)

local function Accelerator(limit, tbl)
  local step = 0
  local prev = 0
  local ceil = #tbl

  return {
    advance = function(now)
      if now - prev < limit then
        step = step < ceil and step + 1 or ceil
      else
        step = 0
      end
      prev = now
      return step == 0 and 1 or tbl[step]
    end,
    reset = function()
      step = 0
    end,
  }
end

-- ===========================================================================
-- Keymap binding — connects an Accelerator to a Neovim expr mapping
-- ===========================================================================

---@param accel Accelerator
---@param key string  "j" | "k"
---@return function    callback for { expr = true } keymap
local function bind(accel, key)
  return function()
    local c = vim.v.count
    if c > 0 then
      accel.reset()
      return c .. key
    end
    return accel.advance(vim.uv.now()) .. key
  end
end

-- ===========================================================================
-- Public API
-- ===========================================================================

---@param opts? { acceleration_limit?: number, acceleration_table?: number[] }
function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  local j = Accelerator(opts.acceleration_limit, opts.acceleration_table)
  local k = Accelerator(opts.acceleration_limit, opts.acceleration_table)

  vim.keymap.set({ "n", "x", "o" }, "j", bind(j, "j"), { expr = true, desc = "Accelerated j" })
  vim.keymap.set({ "n", "x", "o" }, "k", bind(k, "k"), { expr = true, desc = "Accelerated k" })
end

return M
