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

local sdkman_dir = os.getenv("SDKMAN_DIR")
local java_bin = sdkman_dir .. "/candidates/java/25.0.1-tem/bin/java"

local M = {}

M.get_workspace_dir = function()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name
end

M.java_bin = function()
  return java_bin
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

M.get_sdkman_java_runtimes = function()
  local runtimes = {}
  local sdkman_java_path = vim.fn.expand(sdkman_dir .. "/candidates/java")

  if vim.fn.isdirectory(sdkman_java_path) == 0 then
    return runtimes
  end

  -- Java SE 版本命名映射
  local java_se_names = {
    ["1"] = "JavaSE-1.1",
    ["2"] = "JavaSE-1.2",
    ["3"] = "JavaSE-1.3",
    ["4"] = "JavaSE-1.4",
    ["5"] = "JavaSE-1.5",
    ["6"] = "JavaSE-1.6",
    ["7"] = "JavaSE-1.7",
    ["8"] = "JavaSE-1.8",
  }

  local function get_java_se_name(major_version)
    if java_se_names[major_version] then
      return java_se_names[major_version]
    else
      return "JavaSE-" .. major_version
    end
  end

  local handle = vim.loop.fs_scandir(sdkman_java_path)
  if not handle then
    return runtimes
  end

  local seen_paths = {}

  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end

    if (type == "directory" or type == "link") and name ~= "current" then
      local full_path = sdkman_java_path .. "/" .. name
      local real_path = vim.fn.resolve(full_path)

      if not seen_paths[real_path] and vim.fn.executable(full_path .. "/bin/java") == 1 then
        seen_paths[real_path] = true

        -- 提取主版本号
        local major_version = name:match("^(%d+)%.") or name:match("^(%d+)%-") or name:match("^(%d+)$")

        if major_version then
          table.insert(runtimes, {
            name = get_java_se_name(major_version),
            path = full_path,
            version_string = name,
          })
        end
      end
    end
  end

  -- 标记默认版本
  local current_path = sdkman_java_path .. "/current"
  if vim.fn.isdirectory(current_path) == 1 then
    local current_real = vim.fn.resolve(current_path)
    for _, runtime in ipairs(runtimes) do
      if vim.fn.resolve(runtime.path) == current_real then
        runtime.default = true
        break
      end
    end
  end

  -- 选择默认版本
  if #runtimes > 0 then
    local has_default = false
    for _, runtime in ipairs(runtimes) do
      if runtime.default then
        has_default = true
        break
      end
    end

    if not has_default then
      -- 按实际版本号排序
      table.sort(runtimes, function(a, b)
        -- 提取纯数字版本号用于比较
        local get_numeric_version = function(name)
          local v1 = name:match("JavaSE%-1%.(%d+)")
          if v1 then
            return tonumber(v1)
          end
          local v2 = name:match("JavaSE%-(%d+)")
          if v2 then
            return tonumber(v2)
          end
          return 0
        end
        return get_numeric_version(a.name) > get_numeric_version(b.name)
      end)
      runtimes[1].default = true
    end
  end

  return runtimes
end

return M
