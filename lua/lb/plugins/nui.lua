--=====================================================================
--
-- nui.lua -
--
-- Created by liubang on 2022/09/03 21:30
-- Last Modified: 2022/09/03 21:30
--
--=====================================================================

local nui_input = require 'nui.input'
local event = require('nui.utils.autocmd').event

local function override_ui_input()
  local UIInput = nui_input:extend 'UIInput'
  function UIInput:init(opts, on_done)
    local default_value = tostring(opts.default)
    UIInput.super.init(self, {
      relative = 'cursor',
      position = {
        row = 1,
        col = 0,
      },
      size = {
        width = math.max(25, vim.api.nvim_strwidth(default_value)),
      },
      border = {
        style = 'single',
        text = {
          top = '─ [Input] ',
          top_align = 'left',
        },
      },
      win_options = {
        winhighlight = 'Normal:Normal,FloatBorder:Grey',
      },
    }, {
      prompt = '  ',
      default_value = default_value,
      on_close = function()
        on_done(nil)
      end,
      on_submit = function(value)
        on_done(value)
      end,
    })

    -- cancel operation if cursor leaves input
    self:on(event.BufLeave, function()
      on_done(nil)
    end, { once = true })

    -- cancel operation if <Esc> is pressed
    self:map('n', '<Esc>', function()
      on_done(nil)
    end, { noremap = true, nowait = true })
  end

  local input_ui

  vim.ui.input = function(opts, on_confirm)
    assert(type(on_confirm) == 'function', 'missing on_confirm function')

    if input_ui then
      -- ensure single ui.input operation
      vim.api.nvim_err_writeln 'busy: another input is pending!'
      return
    end

    input_ui = UIInput(opts, function(value)
      if input_ui then
        -- if it's still mounted, unmount it
        input_ui:unmount()
      end
      -- pass the input value
      on_confirm(value)
      -- indicate the operation is done
      input_ui = nil
    end)

    input_ui:mount()
  end
end

local async_load_plugin = nil
async_load_plugin = vim.loop.new_async(vim.schedule_wrap(function()
  override_ui_input()
  async_load_plugin:close()
end))
async_load_plugin:send()
