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

return {
  {
    "nvim-java/nvim-java",
    ft = { "java", "jproperties" },
    init = function()
      vim.env.JAVA_HOME = vim.env["JAVA_25_HOME"]
      vim.env.PATH = vim.env.JAVA_HOME .. "/bin" .. ":" .. vim.env.PATH
    end,
    config = function()
      local defaults = require("plugins.lsp.defaults")
      local cfg = require("plugins.java.config")

      --- Walk up from the current buffer's directory to find the nearest
      --- build file (pom.xml / build.gradle / build.gradle.kts), then check
      --- whether it contains a spring-boot dependency declaration.
      --- This works correctly in monorepos where cwd != project root.
      local function is_spring_boot_project()
        local bufpath = vim.api.nvim_buf_get_name(0)
        if bufpath == "" then
          return false
        end
        local build_files = { "pom.xml", "build.gradle", "build.gradle.kts" }
        local found = vim.fs.find(build_files, {
          path = vim.fs.dirname(bufpath),
          upward = true,
          stop = vim.uv.os_homedir(),
          type = "file",
        })
        if #found == 0 then
          return false
        end
        local f = io.open(found[1], "r")
        if not f then
          return false
        end
        local content = f:read("*a")
        f:close()
        return content ~= nil and content:find("spring%-boot") ~= nil
      end

      require("java").setup({
        jdk = { auto_install = false },
        spring_boot_tools = { enable = is_spring_boot_project() },
      })

      -- Patch spring-boot.nvim: client.request -> client:request (deprecated in 0.12)
      -- Fixed upstream in affc5d1, but nvim-java pins an older commit.
      -- Remove this block once nvim-java updates its spring-boot.nvim dependency.
      do
        local spring_plugin = require("lazy.core.config").plugins["spring-boot.nvim"]
        local spring_dir = spring_plugin and spring_plugin.dir or ""
        if spring_dir ~= "" then
          -- `--is-ancestor affc5d1 HEAD` exits 0 if the fix is included, non-zero otherwise
          local result =
            vim.system({ "git", "-C", spring_dir, "merge-base", "--is-ancestor", "affc5d1", "HEAD" }):wait()
          if result.code ~= 0 then
            local spring_util = require("spring_boot.util")
            spring_util.execute_command = function(client, command, param, callback)
              local co
              if not callback then
                co = coroutine.running()
                if co then
                  callback = function(err, resp)
                    coroutine.resume(co, err, resp)
                  end
                end
              end
              client:request("workspace/executeCommand", {
                command = command,
                arguments = param,
              }, callback)
              if co then
                return coroutine.yield()
              end
            end
          end
        end
      end

      -- Override nvim-java's multi_select with custom floating checkbox UI
      local java_ui = require("java.ui.utils")
      local async_wait = require("async.waits.wait")
      local multi_select = require("venux.ui.multi_select")

      java_ui.multi_select = function(prompt, values, format_item)
        return async_wait(function(callback)
          vim.schedule(function()
            local selected = multi_select.open(prompt, values, {
              format_item = format_item,
              title = " Select Fields ",
            })
            callback(selected)
          end)
        end)
      end

      defaults.enable("jdtls", cfg.jdtls_config())
    end,
  },
}
