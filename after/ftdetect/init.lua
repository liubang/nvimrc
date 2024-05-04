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

vim.filetype.add({ -- {{{
  filename = {
    [".clangd"] = "yaml",
    [".clang-format"] = "yaml",
    [".bazelrc"] = "bzl",
    [".gitignore"] = "gitconfig",
    ["go.sum"] = "gosum",
    ["go.mod"] = "gomod",
    ["BUILD"] = "bzl",
    ["BCLOUD"] = "bzl",
    ["WORKSPACE"] = "bzl",
  },
  extension = {
    thrift = "thrift",
    wiki = "markdown",
  },
  pattern = {
    ["*.log"] = "log",
    ["*_LOG"] = "log",
  },
}) -- }}}
