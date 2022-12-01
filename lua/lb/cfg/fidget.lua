--=====================================================================
--
-- fidget.lua -
--
-- Created by liubang on 2022/09/03 16:53
-- Last Modified: 2022/10/18 23:28
--
--=====================================================================

require('fidget').setup {
  text = {
    spinner = {
      '⊚∙∙∙∙',
      '∙⊚∙∙∙',
      '∙∙⊚∙∙',
      '∙∙∙⊚∙',
      '∙∙∙∙⊚',
      '∙∙∙⊚∙',
      '∙∙⊚∙∙',
      '∙⊚∙∙∙',
    },
    done = '',
    commenced = 'Started',
    completed = 'Completed',
  },
  window = {
    relative = 'editor',
    blend = 0,
  },
  fmt = {
    stack_upwards = false,
    fidget = function(fidget_name, spinner)
      return string.format('%s %s', spinner, fidget_name)
    end,
    -- function to format each task line
    task = function(task_name, message, percentage)
      return string.format(
        '%s%s [%s]',
        message,
        percentage and string.format(' (%s%%)', percentage) or '',
        task_name
      )
    end,
  },
}

-- vim.api.nvim_create_autocmd('VimLeavePre', { command = 'FidgetClose' })
