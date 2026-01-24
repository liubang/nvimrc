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

local u = require("lb.utils.util")

local M = {}

M.java_bin = os.getenv("JAVA_21_HOME") .. "/bin/java"

M.get_workspace_dir = function()
  local config = vim.lsp.config["jdtls"]
  local root_dir = config.root_dir or vim.fs.root(0, config.root_markers)
  local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
  local hash = vim.fn.sha256(root_dir):sub(1, 8)
  return vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name .. "-" .. hash
end

M.maven_settings = function()
  if vim.fn.filereadable(vim.fn.expand("~/.m2/settings.xml")) == 1 then
    return vim.fn.expand("~/.m2/settings.xml")
  end
  return ""
end

M.fmt_config = function()
  local fmt_path = vim.uv.cwd() .. "/eclipse-formatter.xml"
  local has_fmt = vim.uv.fs_stat(fmt_path)
  if has_fmt then
    return {
      url = fmt_path,
      profile = "Eclipse",
    }
  end
  return {}
end

M.test_with_profile = function(test_fn)
  local choices = {
    "cpu,alloc=2m,lock=10ms",
    "cpu",
    "alloc",
    "wall",
    "context-switches",
    "cycles",
    "instructions",
    "cache-misses",
  }
  local select_opts = {
    format_item = tostring,
  }
  local async_profiler_home = vim.fn.stdpath("config") .. "/data/async-profiler/"
  local async_profiler_so = async_profiler_home
  local async_profiler_cov = async_profiler_home .. "jfr-converter.jar"
  if u.is_linux then
    async_profiler_so = async_profiler_so .. "async-profiler-4.2.1-linux-x64/lib/libasyncProfiler.so"
  elseif u.is_mac then
    async_profiler_so = async_profiler_so .. "async-profiler-4.2.1-macos/lib/libasyncProfiler.dylib"
  end

  return function()
    vim.ui.select(choices, select_opts, function(choice)
      if not choice then
        return
      end
      local event = "event=" .. choice
      local vmArgs = "-ea -agentpath:" .. async_profiler_so .. "=start,"
      vmArgs = vmArgs .. event .. ",file=/tmp/profile.jfr"
      test_fn({
        config_overrides = {
          vmArgs = vmArgs,
          noDebug = true,
        },
        after_test = function()
          local result = vim
            .system({
              "java",
              "-jar",
              async_profiler_cov,
              "/tmp/profile.jfr",
              "/tmp/profile.html",
            })
            :wait()
          if result.code == 0 then
            u.open("/tmp/profile.html")
          else
            vim.notify("Async Profiler conversion failed: " .. result.stderr, vim.log.levels.ERROR)
          end
        end,
      })
    end)
  end
end

-- see https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
local ExecutionEnvironment = {
  J2SE_1_5 = "J2SE-1.5",
  JavaSE_1_6 = "JavaSE-1.6",
  JavaSE_1_7 = "JavaSE-1.7",
  JavaSE_1_8 = "JavaSE-1.8",
  JavaSE_9 = "JavaSE-9",
  JavaSE_10 = "JavaSE-10",
  JavaSE_11 = "JavaSE-11",
  JavaSE_12 = "JavaSE-12",
  JavaSE_13 = "JavaSE-13",
  JavaSE_14 = "JavaSE-14",
  JavaSE_15 = "JavaSE-15",
  JavaSE_16 = "JavaSE-16",
  JavaSE_17 = "JavaSE-17",
  JavaSE_18 = "JavaSE-18",
  JavaSE_19 = "JavaSE-19",
  JAVASE_20 = "JavaSE-20",
  JAVASE_21 = "JavaSE-21",
  JAVASE_22 = "JavaSE-22",
  JAVASE_23 = "JavaSE-23",
  JAVASE_24 = "JavaSE-24",
  JAVASE_25 = "JavaSE-25",
}

local function get_java_ver_home(v, dv)
  return vim.env["JAVA_" .. v .. "_HOME"] or dv
end

M.runtimes = function()
  local result = {}
  for _, value in pairs(ExecutionEnvironment) do
    local version = vim.fn.split(value, "-")[2]
    if string.match(version, "%.") then
      version = vim.split(version, "%.")[2]
    end
    local java_home = get_java_ver_home(version)
    local default_jdk = false
    if java_home then
      local java_sources = java_home .. "/lib/src.zip"
      if ExecutionEnvironment.JavaSE_17 == value then
        default_jdk = true
      end
      table.insert(result, {
        name = value,
        path = java_home,
        sources = java_sources,
        default = default_jdk,
      })
    end
  end
  if #result == 0 then
    vim.notify("Please config Java runtimes (JAVA_17_HOME...)")
  end
  return result
end

M.setup_jdtls_pick_many = function()
  local jdtls_ui = require("jdtls.ui")

  jdtls_ui.pick_many = function(_, prompt, label_f, items)
    if not items or #items == 0 then
      return {}
    end

    label_f = label_f or function(item)
      return item
    end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local sorters = require("telescope.sorters")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local co = coroutine.running()

    pickers
      .new({
        layout_config = {
          prompt_position = "top",
          width = 0.55,
          height = 0.55,
          preview_cutoff = 120,
        },
      }, {
        prompt_title = prompt,
        finder = finders.new_table({
          results = items,
          entry_maker = function(item)
            return {
              value = item,
              display = label_f(item),
              ordinal = label_f(item),
            }
          end,
        }),
        sorter = sorters.get_fzy_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          local function confirm()
            local picker = action_state.get_current_picker(prompt_bufnr)
            local selections = picker:get_multi_selection()
            if vim.tbl_isempty(selections) then
              local selection = action_state.get_selected_entry()
              if selection then
                table.insert(selections, selection)
              end
            end

            actions.close(prompt_bufnr)

            local result = {}
            for _, sel in ipairs(selections) do
              table.insert(result, sel.value)
            end
            if co then
              coroutine.resume(co, result)
            end
          end

          map("i", "<C-a>", function()
            actions.toggle_all(prompt_bufnr)
          end)

          map({ "i", "n" }, "<Esc>", function()
            actions.close(prompt_bufnr)
            if co then
              coroutine.resume(co, {})
            end
          end)

          actions.select_default:replace(confirm)
          return true
        end,
      })
      :find()

    return coroutine.yield()
  end
end

M.setup_jdtls_pick_one = function()
  local jdtls_ui = require("jdtls.ui")

  jdtls_ui.pick_one = function(items, prompt, label_fn)
    if not items or #items == 0 then
      return nil
    end

    -- 确保 label_fn 存在
    label_fn = label_fn or function(item)
      return item
    end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local actions = require("telescope.actions")
    local sorters = require("telescope.sorters")
    local action_state = require("telescope.actions.state")

    local co = coroutine.running()

    pickers
      .new({
        layout_config = {
          prompt_position = "top",
          width = 0.55,
          height = 0.55,
          preview_cutoff = 120,
        },
      }, {
        prompt_title = prompt,
        finder = finders.new_table({
          results = items,
          entry_maker = function(item)
            return {
              value = item,
              display = label_fn(item),
              ordinal = label_fn(item),
            }
          end,
        }),
        sorter = sorters.get_fzy_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          map("i", "<Tab>", function() end)
          map("i", "<S-Tab>", function() end)
          map("n", "<Tab>", function() end)
          map("n", "<S-Tab>", function() end)

          actions.select_default:replace(function()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if co and selection then
              coroutine.resume(co, selection.value)
            end
          end)
          vim.keymap.set({ "i", "n" }, "<Esc>", function()
            actions.close(prompt_bufnr)
            if co then
              coroutine.resume(co, nil)
            end
          end, { buffer = prompt_bufnr })
          return true
        end,
      })
      :find()
    return coroutine.yield()
  end
end

return M
