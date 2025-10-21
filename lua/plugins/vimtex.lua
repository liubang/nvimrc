-- Copyright (c) 2025 The Authors. All rights reserved.
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
    "lervag/vimtex",
    ft = { "tex", "bib", "cls" },
    init = function()
      vim.g.vimtex_indent_enabled = false -- Disable auto-indent from Vimtex
      vim.g.tex_indent_items = false -- Disable indent for enumerate
      vim.g.tex_indent_brace = false -- Disable brace indent
      -- Suppression settings
      vim.g.vimtex_quickfix_mode = 0 -- Suppress quickfix on save/build
      -- Other settings
      vim.g.vimtex_mappings_enabled = false -- Disable default mappings
      vim.g.tex_flavor = "latex" -- Set file type for TeX files
      vim.g.vimtex_compiler_method = "latexmk"

      local uv = vim.uv
      local os = uv.os_uname().sysname
      if os == "Linux" then
        vim.g.vimtex_view_method = "zathura"
      else
        vim.g.vimtex_view_method = "skim"
      end
      vim.g.vimtex_compiler_latexmk_engines = {
        ["_"] = "-pdf",
        pdflatex = "-pdf",
        dvipdfex = "-pdfdvi",
        lualatex = "-lualatex",
        xelatex = "-xelatex",
        ["context (pdftex)"] = "-pdf -pdflatex=texexec",
        ["context (luatex)"] = "-pdf -pdflatex=context",
        ["context (xetex)"] = "-pdf -pdflatex=texexec --xtx",
      }
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "build",
        options = {
          "-file-line-error",
          "-interaction=nonstopmode",
          "-synctex=1",
          "-shell-escape",
        },
      }
    end,
  },
}
