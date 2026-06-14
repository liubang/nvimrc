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

local M = {}

local active_bazel_term = nil
local bazel_keymap_installed = false

local function bazel_terminal_height()
  return math.max(12, math.floor(vim.o.lines * 0.5))
end

local function toggle_active_bazel_term()
  if active_bazel_term and active_bazel_term.bufnr and vim.api.nvim_buf_is_valid(active_bazel_term.bufnr) then
    active_bazel_term:toggle(bazel_terminal_height(), "horizontal")
    return
  end

  vim.cmd("ToggleTerm direction=float")
end

local function install_bazel_toggle_keymap()
  if bazel_keymap_installed then
    return
  end

  vim.keymap.set("n", "<C-t>", toggle_active_bazel_term, {
    desc = "Toggle Bazel terminal",
  })
  bazel_keymap_installed = true
end

local function get_bazel_root()
  local path = vim.api.nvim_buf_get_name(0)

  if path == "" then
    path = vim.loop.cwd()
  end

  return vim.fs.root(path, {
    "MODULE.bazel",
    "WORKSPACE",
    "WORKSPACE.bazel",
    "WORKSPACE.bzlmod",
  })
end

local function run_in_toggleterm(cmd, cwd)
  local Terminal = require("toggleterm.terminal").Terminal
  local short_cmd = cmd:gsub("^bazel%s+", "")
  local cwd_name = vim.fn.fnamemodify(cwd, ":t")
  local action_name, target = short_cmd:match("^(%S+)%s+(.+)$")

  if not action_name then
    action_name = short_cmd
    target = ""
  end

  local function setup_winbar()
    vim.api.nvim_set_hl(0, "BazelWinbar", { link = "WinBar", default = true })
    vim.api.nvim_set_hl(0, "BazelWinbarTitle", { link = "Title", default = true })
    vim.api.nvim_set_hl(0, "BazelWinbarAction", { link = "Statement", default = true })
    vim.api.nvim_set_hl(0, "BazelWinbarTarget", { link = "String", default = true })
    vim.api.nvim_set_hl(0, "BazelWinbarDir", { link = "Directory", default = true })
    vim.api.nvim_set_hl(0, "BazelWinbarDim", { link = "Comment", default = true })
  end

  local function stl_escape(text)
    return tostring(text):gsub("%%", "%%%%")
  end

  local function winbar()
    local width = vim.o.columns
    local max_target_width = math.max(24, math.floor(width * 0.5))
    local display_target = target

    if vim.fn.strdisplaywidth(display_target) > max_target_width then
      display_target = vim.fn.strcharpart(display_target, 0, max_target_width - 3) .. "..."
    end

    return table.concat({
      "%#BazelWinbar# ",
      "%#BazelWinbarTitle#Bazel",
      "%#BazelWinbarDim# : ",
      "%#BazelWinbarAction#",
      stl_escape(action_name),
      "%#BazelWinbarDim#  ",
      "%#BazelWinbarTarget#",
      stl_escape(display_target),
      "%=",
      "%#BazelWinbarDim#cwd ",
      "%#BazelWinbarDir#",
      stl_escape(cwd_name),
      "%#BazelWinbar# ",
    })
  end

  install_bazel_toggle_keymap()

  active_bazel_term = Terminal:new({
    cmd = cmd,
    dir = cwd,
    direction = "horizontal",
    size = bazel_terminal_height,
    close_on_exit = false,
    hidden = true,
    on_open = function(term)
      setup_winbar()
      vim.cmd("resize " .. bazel_terminal_height())
      vim.cmd("startinsert")

      if term.window and vim.api.nvim_win_is_valid(term.window) then
        vim.api.nvim_set_option_value("number", false, { win = term.window })
        vim.api.nvim_set_option_value("relativenumber", false, { win = term.window })
        vim.api.nvim_set_option_value("signcolumn", "no", { win = term.window })
        vim.api.nvim_set_option_value("foldcolumn", "0", { win = term.window })
        vim.api.nvim_set_option_value("winfixheight", true, { win = term.window })
        vim.api.nvim_set_option_value("winhighlight", "WinBar:BazelWinbar,WinBarNC:BazelWinbar", {
          win = term.window,
        })
        vim.api.nvim_set_option_value("winbar", winbar(), { win = term.window })
      end

      local bufnr = term.bufnr or vim.api.nvim_get_current_buf()
      if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
        vim.keymap.set({ "n", "t" }, "<C-t>", function()
          term:toggle(bazel_terminal_height(), "horizontal")
        end, {
          buffer = bufnr,
          desc = "Toggle Bazel terminal",
        })
      end
    end,
  })

  active_bazel_term:toggle(bazel_terminal_height(), "horizontal")
end

---@param title string
---@param kind string|nil Bazel rule kind pattern (e.g. "cc_test", ".*_test")
---@param action string Bazel action (build, test, run)
local function bazel_finder(title, kind, action)
  if vim.fn.executable("bazel") ~= 1 then
    vim.notify("You need to install bazel", vim.log.levels.ERROR)
    return
  end

  local root = get_bazel_root()
  if not root then
    vim.notify("The bazel command is only supported within a Bazel workspace", vim.log.levels.ERROR)
    return
  end

  local query
  if kind == nil or kind == "" then
    query = 'kind(".* rule", //...)'
  else
    query = string.format('kind("%s rule", //...)', kind)
  end

  local find_command = {
    "bazel",
    "query",
    query,
    "--keep_going",
    "--noshow_progress",
    "--output=label",
  }

  Snacks.picker({
    title = title,
    finder = function(_opts, _ctx)
      local output = vim.fn.systemlist(find_command, root)
      local items = {}
      for _, line in ipairs(output) do
        -- Strip ANSI escape codes (bazel may output colored text)
        local clean = line:gsub("\27%[[%d;]*%a", "")
        if clean ~= "" then
          items[#items + 1] = {
            text = clean,
            value = clean,
          }
        end
      end
      return items
    end,
    format = function(item, _picker)
      return { { item.value, "SnacksPickerLabel" } }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item or not item.value or item.value == "" then
        return
      end

      local target = item.value
      local cmd = string.format("bazel %s %s", action, target)

      run_in_toggleterm(cmd, root)
    end,
  })
end

---@param opts? table
function M.build(opts)
  bazel_finder("BazelBuild", "", "build")
end

---@param opts? table
function M.test(opts)
  bazel_finder("BazelTest", ".*_test", "test")
end

---@param opts? table
function M.run(opts)
  bazel_finder("BazelRun", ".*_binary", "run")
end

---@param opts? table
function M.cc_rules(opts)
  bazel_finder("BazelCCBuild", "cc_.*", "build")
end

---@param opts? table
function M.cc_tests(opts)
  bazel_finder("BazelCCTest", "cc_test", "test")
end

---@param opts? table
function M.cc_run(opts)
  bazel_finder("BazelCCRun", "cc_binary", "run")
end

return M
