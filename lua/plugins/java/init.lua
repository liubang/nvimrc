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

local cfg = require("plugins.java.config")

return {
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "xml", "jproperties" },
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = cfg.spring_boot_opts(),
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java", "xml", "jproperties" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local group = vim.api.nvim_create_augroup("JdtlsGroup", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = { "java", "xml", "jproperties" },
        callback = function(_)
          require("jdtls").start_or_attach(cfg.jdtls_config())
        end,
      })
    end,
  },
}
