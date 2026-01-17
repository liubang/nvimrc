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

local lemminx_jars = {}
local jar_dir = vim.fn.stdpath("config") .. "/data/jars/"
local lemminx_home = jar_dir .. "lemminx"

for _, bundle in ipairs(vim.split(vim.fn.glob(lemminx_home .. "/*.jar"), "\n")) do
  table.insert(lemminx_jars, bundle)
end

-- note: linux and maxos
vim.fn.join(lemminx_jars, ":")

return {
  name = "lemminx",
  cmd = {
    require("plugins.java.utils").java_bin(),
    "-cp",
    vim.fn.join(lemminx_jars, ":"),
    "org.eclipse.lemminx.XMLServerLauncher",
  },
  settings = {
    lemminx = {},
  },
  filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
  root_dir = vim.fs.root(0, { ".git" }) or vim.uv.cwd(),
  single_file_support = true,
}
