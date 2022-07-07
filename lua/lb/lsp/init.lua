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
  require 'lb.lsp.null-ls'
  require 'lb.lsp.handlers'
  require 'lb.lsp.events'
end

return {
  setup = setup,
}
