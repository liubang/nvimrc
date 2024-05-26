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

return {
  "j-hui/fidget.nvim", -- {{{
  event = { "LspAttach" },
  opts = {
    progress = {
      ignore = { "null-ls" },
      display = {
        format_message = function(msg)
          if string.find(msg.title, "Indexing") then
            return nil -- Ignore "Indexing..." progress messages
          end
          if msg.message then
            return msg.message
          else
            return msg.done and "Completed" or "In progress..."
          end
        end,
      },
    },
    notification = {
      view = {
        stack_upwards = false, -- Display notification items from bottom to top
      },
      window = {
        relative = "editor",
        winblend = 0,
      },
      -- override_vim_notify = false,
    },
  },
  -- }}}
}
