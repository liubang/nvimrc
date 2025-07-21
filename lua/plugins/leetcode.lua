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
  "liubang/leetcode.nvim",
  cmd = "Leet",
  opts = {
    lang = "cpp",
    cn = {
      enabled = true,
      translator = false,
      translate_problems = true,
    },
    storage = {
      home = os.getenv("GIT_WORKSPACE") .. "/leetcode/src",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    picker = {
      provider = "telescope",
    },
    injector = {
      ["cpp"] = {
        imports = function()
          return {
            "#include <gtest/gtest.h>",
            "#include <vector>",
            "#include <string>",
            "using namespace std;",
          }
        end,
        before = {
          "namespace {",
        },
        after = {
          "}",
          "TEST(Leetcode, <FILE_NAME_NOEXT>) {",
          "    Solution s;",
          "    // run cases",
          "}",
        },
      },
    },
    theme = {
      easy = { fg = "#a9b665" },
      medium = { fg = "#7daea3" },
      hard = { fg = "#ea6962" },
      easy_alt = { fg = "#a9b665" },
      medium_alt = { fg = "#7daea3" },
      hard_alt = { fg = "#ea6962" },
    },
  },
}
