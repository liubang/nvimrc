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
  settings = {
    ["rust-analyzer"] = {
      -- 用 clippy 替代 check，诊断质量更高（保存时触发）
      check = { command = "clippy" },
      cargo = { features = "all" },
    },
  },
  -- lspconfig 默认配置里的 on_attach（提供 :LspCargoReload）会被
  -- defaults.enable 的全局 on_attach 覆盖，这里手动补回
  on_attach = function(client, buf)
    vim.api.nvim_buf_create_user_command(buf, "LspCargoReload", function()
      vim.notify("Reloading Cargo Workspace")
      client:request("rust-analyzer/reloadWorkspace", nil, function(err)
        if err then
          vim.notify(tostring(err), vim.log.levels.ERROR)
          return
        end
        vim.notify("Cargo workspace reloaded")
      end, buf)
    end, { desc = "Reload current cargo workspace" })
  end,
}
