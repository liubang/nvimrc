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
local health = vim.health

--- Check a single executable and report ok/error.
---@param bin string  executable name
---@param name string  human-readable name
---@param advice string  install hint when missing
---@param severity? "error"|"warn"  default "error"
local function check_executable(bin, name, advice, severity)
  severity = severity or "error"
  if vim.fn.executable(bin) == 1 then
    health.ok(string.format("%s is installed", name))
  else
    health[severity](string.format("Please install %s, %s", name, advice))
  end
end

--- Check a group of executables under a shared heading.
---@param title string
---@param items {bin:string,name:string,advice:string,severity?:string}[]
local function check_group(title, items)
  health.start(title)
  for _, it in ipairs(items) do
    check_executable(it.bin, it.name, it.advice, it.severity)
  end
end

M.check = function()
  -- ── Core ──────────────────────────────────────────────────────────
  check_group("Checking core requirements", {
    { bin = "rg",     name = "ripgrep",  advice = "Refer to https://github.com/BurntSushi/ripgrep#installation" },
    { bin = "git",    name = "git",      advice = "Refer to https://git-scm.com/downloads" },
    { bin = "curl",   name = "curl",     advice = "Refer to https://curl.se/download.html", severity = "warn" },
  })

  -- ── LSP servers (ensure_installed via mason) ──────────────────────
  check_group("Checking LSP servers", {
    { bin = "clangd", name = "clangd", advice = "Install via mason (:Mason) or system package", severity = "warn" },
    { bin = "gopls",  name = "gopls",  advice = "Run `go install golang.org/x/tools/gopls@latest`", severity = "warn" },
    { bin = "lua_ls", name = "lua-language-server", advice = "Install via mason (:Mason)", severity = "warn" },
  })

  -- ── Formatters (conform.nvim) ─────────────────────────────────────
  check_group("Checking formatters", {
    { bin = "stylua",            name = "StyLua",      advice = "Refer to https://github.com/JohnnyMorganz/StyLua#installation", severity = "warn" },
    { bin = "gofumpt",           name = "gofumpt",     advice = "Run `go install mvdan.cc/gofumpt@latest`", severity = "warn" },
    { bin = "shfmt",             name = "shfmt",       advice = "Refer to https://github.com/mvdan/sh#shfmt", severity = "warn" },
    { bin = "prettier",          name = "prettier",    advice = "Run `npm install -g prettier`", severity = "warn" },
    { bin = "buildifier",        name = "buildifier",  advice = "Refer to https://github.com/bazelbuild/buildtools", severity = "warn" },
    { bin = "sql-formatter",     name = "sql-formatter", advice = "Run `npm install -g sql-formatter`", severity = "warn" },
    { bin = "asmfmt",            name = "asmfmt",      advice = "Refer to https://github.com/klauspost/asmfmt", severity = "warn" },
  })

  -- ── Linters (nvim-lint) ───────────────────────────────────────────
  check_group("Checking linters", {
    { bin = "buildifier", name = "buildifier (lint)", advice = "Refer to https://github.com/bazelbuild/buildtools", severity = "warn" },
    { bin = "actionlint", name = "actionlint",        advice = "Refer to https://github.com/rhysd/actionlint", severity = "warn" },
  })

  -- ── Build / task tools ────────────────────────────────────────────
  check_group("Checking build & task tools", {
    { bin = "bazel", name = "bazel", advice = "Refer to https://bazel.build/install", severity = "warn" },
    { bin = "make",  name = "make",  advice = "Install via system package manager", severity = "warn" },
  })

  -- ── Language-specific toolchains ──────────────────────────────────
  check_group("Checking language toolchains", {
    { bin = "java",     name = "java",     advice = "Set JAVA_17_HOME / JAVA_21_HOME / JAVA_25_HOME", severity = "warn" },
    { bin = "go",       name = "go",       advice = "Refer to https://go.dev/doc/install", severity = "warn" },
    { bin = "node",     name = "node",     advice = "Refer to https://nodejs.org/", severity = "warn" },
    { bin = "python3",  name = "python3",  advice = "Refer to https://www.python.org/", severity = "warn" },
    { bin = "latexmk",  name = "latexmk",  advice = "Install texlive or mactex", severity = "warn" },
    { bin = "tree-sitter", name = "tree-sitter CLI", advice = "Refer to https://github.com/tree-sitter/tree-sitter", severity = "warn" },
  })
end

return M

-- vim: fdm=marker fdl=0
