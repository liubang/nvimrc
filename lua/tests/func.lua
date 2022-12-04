--=====================================================================
--
-- func.lua -
--
-- Created by liubang on 2022/09/03 22:10
-- Last Modified: 2022/09/03 22:10
--
--=====================================================================

-- local C = function(name)
--   print(name)
--   return function()
--     print(name)
--   end
-- end
--
-- local fn = C 'Ok'
-- fn()

vim.ui.select({ "tabs", "spaces" }, {
  prompt = "Select tabs or spaces:",
  format_item = function(item)
    return "I'd like to choose " .. item
  end,
}, function(choice)
  print(choice)
end)

vim.ui.input({ prompt = "Enter value for shiftwidth: " }, function(input)
  print(input)
end)
