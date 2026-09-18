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

-- NOTE: on_new_config is a legacy nvim-lspconfig callback and is silently
-- ignored by vim.lsp.config (0.11+), so schemas are injected eagerly here.
-- schemastore.nvim is a data-only plugin, loading it is cheap.
local schemas = require("schemastore").json.schemas()

return {
  settings = {
    json = {
      schemas = schemas,
      validate = { enable = true },
      format = { enable = true },
    },
  },
}
