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

if true then
  vim.ui.input({ prompt = "Enter value for shiftwidth: " }, function(input)
    print(input)
  end)

  vim.ui.select({ "tabs", "spaces" }, {
    prompt = "Select tabs or spaces:",
    format_item = function(item)
      return "I'd like to choose " .. item
    end,
  }, function(choice)
    print(choice)
  end)
end

if false then
  local Popup = require("nui.popup")
  local event = require("nui.utils.autocmd").event

  local function confirm_dialog(message, choices, on_confirm)
    choices = choices or { "Yes", "No" }
    local width = math.max(40, #message + 10) -- 根据消息长度动态调整宽度
    local popup = Popup({
      enter = true,
      focusable = true,
      border = {
        style = "single",
        text = { top = " Confirm ", top_align = "center" },
      },
      position = "50%",
      size = {
        width = width,
        height = 6,
      },
      win_options = {
        -- winblend = 1, -- 透明度
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    })

    -- 计算居中的文本
    local function center_text(text, total_width)
      local padding = math.floor((total_width - #text) / 2)
      return string.rep(" ", padding) .. text
    end

    -- 设置窗口内容
    local lines = {
      "", -- 空行填充
      center_text(message, width - 4),
      "",
      center_text("[Y] " .. choices[1] .. "  |  [N] " .. choices[2], width - 4),
      "",
    }
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)

    -- 绑定键盘事件
    popup:map("n", "y", function()
      popup:unmount()
      if on_confirm then
        on_confirm(true)
      end
    end, { noremap = true, nowait = true })

    popup:map("n", "n", function()
      popup:unmount()
      if on_confirm then
        on_confirm(false)
      end
    end, { noremap = true, nowait = true })

    popup:map("n", "<Esc>", function()
      popup:unmount()
    end, { noremap = true, nowait = true })

    -- 监听窗口关闭
    popup:on(event.BufLeave, function()
      popup:unmount()
    end)

    popup:mount()
  end

  -- 测试调用
  confirm_dialog("Do you want to continue?", { "Ok", "No" }, function(confirmed)
    if confirmed then
      print("User chose YES!")
    else
      print("User chose NO.")
    end
  end)
end

vim.fn.confirm("ok", "Y\nN")
