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

do
  local table = setmetatable({
    name = "name",
  }, {
    __index = function(t, key)
      vim.pretty_print(t)
      vim.pretty_print(key)
    end,
  })

  print(table.name)
  _ = table.ok
end

do
  local table = {
    rust = true,
  }

  if table.rust then
    print("RUST OK")
  end

  if table.go then
    print("GO OK")
  else
    print("GO NO")
  end
end
