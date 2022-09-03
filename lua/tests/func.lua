--=====================================================================
--
-- func.lua -
--
-- Created by liubang on 2022/09/03 22:10
-- Last Modified: 2022/09/03 22:10
--
--=====================================================================

local C = function(name)
  print(name)
  return function()
    print(name)
  end
end

local fn = C 'Ok'
fn()
