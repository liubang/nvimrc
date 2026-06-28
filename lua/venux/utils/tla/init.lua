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
TLA+/PlusCal development utilities.

  - TlaInstall   : download latest tla2tools.jar
  - TlaCheck     : run TLC model checker
  - TlaTranslate : translate PlusCal to TLA+

Commands are sent to a terminal backend for execution.
Swap lua/venux/utils/tla/_terminal.lua to change the backend.
--]]

local M = {}

local DATA_DIR = vim.fs.joinpath(vim.fn.stdpath("data"), "tla")

---@return string
local function java_executable()
  if vim.g.tla_java_executable then
    return vim.g.tla_java_executable
  end
  local home = vim.env.JAVA_HOME
  if home then
    return vim.fs.joinpath(home, "bin", "java")
  end
  return "java"
end

---@return string
local function tla2tools_path()
  return vim.g.tla2tools_path or vim.fs.joinpath(DATA_DIR, "tla2tools.jar")
end

---@return string[]
local function java_opts()
  return vim.g.tla_java_opts or { "-XX:+UseParallelGC" }
end

---@return string|nil
local function validate()
  local f = vim.api.nvim_buf_get_name(0)
  if not f:match("%.tla$") then
    vim.notify("[TLA+] Not a .tla file", vim.log.levels.WARN)
    return nil
  end
  if vim.fn.filereadable(tla2tools_path()) == 0 then
    vim.notify("[TLA+] tla2tools.jar not found, run :TlaInstall first", vim.log.levels.ERROR)
    return nil
  end
  return f
end

---@param cmd_str string
local function send(cmd_str)
  require("venux.utils.tla._terminal")(cmd_str)
end

---Build a full command string for a TLA+ tool.
---@param class string
---@param args string[]
---@return string
local function build(class, args)
  local parts = { vim.fn.shellescape(java_executable()) }
  for _, o in ipairs(java_opts()) do
    parts[#parts + 1] = vim.fn.shellescape(o)
  end
  parts[#parts + 1] = "-cp"
  parts[#parts + 1] = vim.fn.shellescape(tla2tools_path())
  parts[#parts + 1] = class
  for _, a in ipairs(args) do
    parts[#parts + 1] = vim.fn.shellescape(a)
  end
  return table.concat(parts, " ")
end

-- ┌──────────────────────────────────────────────────┐
-- │ Public API                                       │
-- └──────────────────────────────────────────────────┘

function M.install()
  vim.fn.mkdir(DATA_DIR, "p")
  local jar = tla2tools_path()
  vim.notify("[TLA+] Fetching latest release info...", vim.log.levels.INFO)
  vim.system(
    { "curl", "-sSL", "https://api.github.com/repos/tlaplus/tlaplus/releases/latest" },
    { text = true },
    vim.schedule_wrap(function(out)
      if out.code ~= 0 or not out.stdout then
        vim.notify("[TLA+] Failed to fetch release info", vim.log.levels.ERROR)
        return
      end
      local ok, rel = pcall(vim.json.decode, out.stdout)
      if not ok or not rel or not rel.assets then
        vim.notify("[TLA+] Failed to parse release info", vim.log.levels.ERROR)
        return
      end
      local url
      for _, a in ipairs(rel.assets) do
        if a.name == "tla2tools.jar" then
          url = a.browser_download_url
          break
        end
      end
      if not url then
        vim.notify("[TLA+] tla2tools.jar not found in release assets", vim.log.levels.ERROR)
        return
      end
      vim.notify("[TLA+] Downloading tla2tools.jar...", vim.log.levels.INFO)
      vim.system(
        { "curl", "-sSL", "-o", jar, url },
        {},
        vim.schedule_wrap(function(dl)
          if dl.code == 0 then
            vim.notify(("[TLA+] Installed tla2tools %s"):format(rel.tag_name or "unknown"), vim.log.levels.INFO)
          else
            vim.notify("[TLA+] Download failed", vim.log.levels.ERROR)
          end
        end)
      )
    end)
  )
end

function M.check()
  local f = validate()
  if not f then
    return
  end
  send(build("tlc2.TLC", {
    f,
    "-tool",
    "-modelcheck",
    "-coverage",
    "1",
    "-config",
    (f:gsub("%.tla$", ".cfg")),
  }))
end

function M.translate()
  local f = validate()
  if not f then
    return
  end
  send(build("pcal.trans", { f }))
end

return M
