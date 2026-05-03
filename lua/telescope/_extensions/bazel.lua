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

local actions = require("telescope.actions")
local actions_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local telescope = require("telescope")

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

local function bazel_finder(opts, title, kind, action)
  opts = opts or {}

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

  pickers
    .new(opts, {
      prompt_title = title,
      sorter = sorters.get_fzy_sorter(opts),

      finder = finders.new_oneshot_job(find_command, {
        cwd = root,
      }),

      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          local selection = actions_state.get_selected_entry()
          actions.close(prompt_bufnr)

          if not selection or selection.value == "" then
            return
          end

          local target = selection.value
          local cmd = string.format("bazel %s %s", action, target)

          run_in_toggleterm(cmd, root)
        end)

        return true
      end,
    })
    :find()
end

local function bazel_build(opts)
  bazel_finder(opts, "BazelBuild", "", "build")
end

local function bazel_tests(opts)
  bazel_finder(opts, "BazelTest", ".*_test", "test")
end

local function bazel_run(opts)
  bazel_finder(opts, "BazelRun", ".*_binary", "run")
end

local function bazel_cc_rules(opts)
  bazel_finder(opts, "BazelCCBuild", "cc_.*", "build")
end

local function bazel_cc_tests(opts)
  bazel_finder(opts, "BazelCCTest", "cc_test", "test")
end

local function bazel_cc_run(opts)
  bazel_finder(opts, "BazelCCRun", "cc_binary", "run")
end

local subcommands = {
  bazel_build = bazel_build,
  bazel_tests = bazel_tests,
  bazel_run = bazel_run,
  bazel_cc_rules = bazel_cc_rules,
  bazel_cc_tests = bazel_cc_tests,
  bazel_cc_run = bazel_cc_run,
}

local function bazel(opts)
  opts = opts or {}

  local subcmd = opts.args or opts[1] or opts.subcmd or opts.subcommand

  if type(subcmd) == "string" then
    subcmd = vim.trim(subcmd)
  end

  if subcmd == nil or subcmd == "" then
    bazel_build(opts)
    return
  end

  local fn = subcommands[subcmd]
  if not fn then
    vim.notify("Unknown bazel picker: " .. tostring(subcmd), vim.log.levels.ERROR)
    return
  end

  fn(opts)
end

return telescope.register_extension({
  exports = {
    bazel = bazel,

    bazel_run = bazel_run,
    bazel_build = bazel_build,
    bazel_tests = bazel_tests,

    bazel_cc_run = bazel_cc_run,
    bazel_cc_rules = bazel_cc_rules,
    bazel_cc_tests = bazel_cc_tests,
  },
})
