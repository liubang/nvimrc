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
-- Created: 2026/06/14 10:44

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = true,
  event = "VeryLazy",
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      row = math.floor(vim.o.lines * 0.2),
      preset = {
        header = [[
 ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
 ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██
▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░
         ░    ░  ░    ░ ░        ░   ░         ░
                                ░                  ]],
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find file", action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "b", desc = "List buffers", action = ":lua Snacks.picker.buffers()" },
          { icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "g", desc = "Find text", action = ":lua Snacks.picker.grep({ hidden = true, ignored = true, need_search = false })" },
          { icon = " ", key = "c", desc = "Config", action = ":e $MYVIMRC" },
          { icon = " ", key = "e", desc = "New file", action = ":ene | startinsert" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    notifier = { enabled = false },
    picker = {
      enabled = true,
      prompt = "   ",
      matcher = {
        fuzzy = true,
        smartcase = true,
        ignorecase = true,
        sort_empty = true,
        filename_bonus = true,
        cwd_bonus = true,
        frecency = true,
      },
      layout = {
        cycle = true,
        preset = function()
          return vim.o.columns >= 120 and "default" or "vertical"
        end,
        hidden = { "preview" },
      },
      sources = {
        files = { hidden = true },
        grep = { hidden = true, layout = { hidden = {} } },
        grep_word = { layout = { hidden = {} } },
        lsp_definitions = { auto_confirm = true },
        lsp_declarations = { auto_confirm = true },
        lsp_implementations = { auto_confirm = true },
        lsp_type_definitions = { auto_confirm = true },
        lsp_references = { auto_confirm = true },
        -- Pickers that benefit from preview
        git_log = { layout = { hidden = {} } },
        git_log_line = { layout = { hidden = {} } },
        git_log_file = { layout = { hidden = {} } },
        git_diff = {
          layout = { hidden = {} },
          win = {
            input = {
              keys = {
                ["<Tab>"] = { "git_stage", mode = { "n", "i" } },
                ["<C-r>"] = { "git_restore", mode = { "n", "i" }, nowait = true },
              },
            },
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "i", "n" } },
            ["<C-c>"] = { "close", mode = { "i", "n" } },
            ["<C-j>"] = { "list_down", mode = { "i", "n" } },
            ["<C-k>"] = { "list_up", mode = { "i", "n" } },
            ["<C-s>"] = { "edit_split", mode = { "i" } },
            ["<C-v>"] = { "edit_vsplit", mode = { "i" } },
            ["<C-t>"] = { "edit_tab", mode = { "i" } },
          },
        },
      },
    },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
  -- stylua: ignore
  keys = {
    -- Core pickers (mirroring telescope keymaps)
    { "<Leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<Leader>rf", function() Snacks.picker.recent() end, desc = "Recent files" },
    { "<Leader>ag", function() Snacks.picker.grep({ hidden = true, ignored = true, need_search = false }) end, desc = "Live grep in files" },
    { "<Leader>Ag", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Search for string under cursor" },
    { "<Leader>bb", function() Snacks.picker.buffers({ sort_lastused = true }) end, desc = "List open buffers" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
    { "<leader>bD", function() Snacks.bufdelete({ force = true }) end, desc = "Delete buffer (force)" },
    -- Bazel (custom)
    { "<Leader>br", function() require("snacks.bazel").run() end, desc = "Bazel run" },
    { "<Leader>bt", function() require("snacks.bazel").test() end, desc = "Bazel test" },
    { "<Leader>bs", function() require("snacks.bazel").build() end, desc = "Bazel build" },
    -- Tasks (custom)
    { "<Leader>ts", function() require("snacks.tasks").tasks() end, desc = "AsyncTasks" },
    -- Additional pickers
    { "<Leader>sb", function() Snacks.picker.lines() end, desc = "Buffer lines" },
    -- Git
    { "<Leader>gf", function() Snacks.picker.git_files() end, desc = "Git files" },
    { "<Leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    { "<Leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },
    { "<Leader>gL", function() Snacks.picker.git_log_file({ follow = true }) end, desc = "Git log (current file)" },
    { "<Leader>gh", function() Snacks.picker.git_log_line({ follow = true }) end, desc = "Git log (current line)" },
    { "<Leader>gv", function() Snacks.picker.git_diff() end, desc = "Git diff (hunks)" },
    { "<Leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)
    -- Override vim.ui.select with snacks (replaces telescope-ui-select)
    vim.ui.select = snacks.picker.select
    -- Dashboard highlights matching alpha-nvim look
    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { link = "Keyword" })
    vim.api.nvim_set_hl(0, "SnacksDashboardKey", { link = "Identifier" })
  end,
}
