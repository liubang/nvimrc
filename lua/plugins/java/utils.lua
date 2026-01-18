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
local sdkman_dir = os.getenv("SDKMAN_DIR")

local M = {}

M.java_bin = sdkman_dir .. "/candidates/java/25.0.1-tem/bin/java"

M.get_workspace_dir = function()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name
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

return M
