-- =====================================================================
--
-- init.lua -
--
-- Created by liubang on 2021/02/06 00:10
-- Last Modified: 2021/02/06 00:10
--
-- =====================================================================

local setup = function()
  require 'lb.lsp.servers'
  require 'lb.lsp.handlers'
  require 'lb.lsp.events'
  require 'lb.lsp.installer'
end

return {
  setup = setup,
}
