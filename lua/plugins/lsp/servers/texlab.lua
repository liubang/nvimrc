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

local forwardSearch = {}

if not require("lb.utils.util").is_mac then
  forwardSearch = {
    executable = "zathura",
    args = { "--synctex-forward", "%l:1:%f", "%p" },
  }
else
  forwardSearch = {
    executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
    args = { "%l", "%p", "%f" },
  }
end

return {
  flags = { allow_incremental_sync = false },
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = "latexmk",
        args = {
          "-xelatex",
          "-file-line-error",
          "-halt-on-error",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-shell-escape",
          -- "-pv",
          "-f",
          "-outdir=build",
          "%f",
        },
        onSave = true,
        forwardSearchAfter = false,
      },
      auxDirectory = "build",
      diagnosticsDelay = 50,
      forwardSearch = forwardSearch,
      chktex = { onOpenAndSave = true, onEdit = false },
      formatterLineLength = 120,
      -- latexFormatter = "latexindent",
      -- latexindent = {
      --   ["local"] = nil, -- local is a reserved keyword
      --   modifyLineBreaks = false,
      -- },
      -- bibtexFormatter = "texlab",
    },
  },
}
