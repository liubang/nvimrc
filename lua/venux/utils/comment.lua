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

local M = {}

M.opts = {
  author = "liubang",
  email = "it.liubang@gmail.com",
}

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
end

-- stylua: ignore
local prefix_mappings = {
  ["c"]               = "//",
  ["cpp"]             = "//",
  ["rust"]            = "//",
  ["go"]              = "//",
  ["php"]             = "//",
  ["java"]            = "//",
  ["lua"]             = "--",
  ["sql"]             = "--",
  ["vim"]             = '"',
  ["bzl"]             = "#",
  ["python"]          = "#",
  ["sh"]              = "#",
  ["zsh"]             = "#",
  ["bash"]            = "#",
  ["make"]            = "#",
  ["ruby"]            = "#",
  ["javascript"]      = "//",
  ["typescript"]      = "//",
  ["javascriptreact"] = "//",
  ["typescriptreact"] = "//",
}

-- stylua: ignore
local shebang_mappings = {
  ["php"]    = { "<?php" },
  ["sh"]     = { "#! /bin/bash" },
  ["zsh"]    = { "#! /usr/bin/env zsh" },
  ["python"] = { "#! /usr/bin/env python", "# -*- coding: utf-8 -*-" },
}

local function get_filetype()
  return vim.api.nvim_get_option_value("filetype", { buf = 0 })
end

local function get_prefix(ft)
  return prefix_mappings[ft] or "#"
end

local function prepend_shebang(text, ft)
  local shebang = shebang_mappings[ft]
  if shebang then
    for _, line in ipairs(shebang) do
      text[#text + 1] = line
    end
  end
end

function M.add_fileheader()
  local text = {}
  prepend_shebang(text, get_filetype())
  if #text > 0 then
    vim.fn.append(0, text)
  end
end

function M.copy_right_apache()
  local ft = get_filetype()
  local c = get_prefix(ft)
  local now = os.date("*t")
  local year = tostring(now.year)
  local created = string.format("%04d/%02d/%02d %02d:%02d", now.year, now.month, now.day, now.hour, now.min)

  local text = {}
  prepend_shebang(text, ft)

  text[#text + 1] = c .. " Copyright (c) " .. year .. " The Authors. All rights reserved."
  text[#text + 1] = c
  text[#text + 1] = c .. ' Licensed under the Apache License, Version 2.0 (the "License");'
  text[#text + 1] = c .. " you may not use this file except in compliance with the License."
  text[#text + 1] = c .. " You may obtain a copy of the License at"
  text[#text + 1] = c
  text[#text + 1] = c .. "      https://www.apache.org/licenses/LICENSE-2.0"
  text[#text + 1] = c
  text[#text + 1] = c .. " Unless required by applicable law or agreed to in writing, software"
  text[#text + 1] = c .. ' distributed under the License is distributed on an "AS IS" BASIS,'
  text[#text + 1] = c .. " WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied."
  text[#text + 1] = c .. " See the License for the specific language governing permissions and"
  text[#text + 1] = c .. " limitations under the License."
  text[#text + 1] = ""
  text[#text + 1] = string.format("%s Authors: %s (%s)", c, M.opts.author, M.opts.email)
  text[#text + 1] = string.format("%s Created: %s", c, created)
  text[#text + 1] = ""

  vim.fn.append(0, text)
end

return M
