--=====================================================================
--
-- fidget.lua -
--
-- Created by liubang on 2022/12/30 22:08
-- Last Modified: 2022/12/31 11:30
--
--=====================================================================

return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  config = function()
    local fidget = require "fidget"
    fidget.setup {
      text = {
        spinner = {
          "⊚∙∙∙∙",
          "∙⊚∙∙∙",
          "∙∙⊚∙∙",
          "∙∙∙⊚∙",
          "∙∙∙∙⊚",
          "∙∙∙⊚∙",
          "∙∙⊚∙∙",
          "∙⊚∙∙∙",
        },
        done = "",
        commenced = "Started",
        completed = "Completed",
      },
      window = {
        relative = "editor",
        blend = 0,
      },
      fmt = {
        stack_upwards = false,
        fidget = function(fidget_name, spinner)
          return string.format("%s %s", spinner, fidget_name)
        end,
        -- function to format each task line
        task = function(task_name, message, percentage)
          return string.format(
            "%s%s [%s]",
            message,
            percentage and string.format(" (%s%%)", percentage) or "",
            task_name
          )
        end,
      },
    }
  end,
}

-- vim: fdm=marker fdl=0
