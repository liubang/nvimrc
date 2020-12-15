--=====================================================================
--
-- commands.lua - 
--
-- Created by liubang on 2020/12/12 18:32
-- Last Modified: 2020/12/12 18:32
--
--=====================================================================

vim.schedule(function()
  vim.cmd [[command! -nargs=0 -bar PlugUpdate call dein#update()]]
  vim.cmd [[command! -nargs=0 -bar PlugClean  call map(dein#check_clean(), "delete(v:val, 'rf')")]]
  vim.cmd [[command! -nargs=0 -bar ReRuntimePath  call dein#recache_runtimepath()]]
  vim.cmd [[command! -nargs=0 CopyRight :lua require('lb.utils.comment').copy_right('liubang')]]
  vim.cmd [[command! -nargs=0 CopyRightUpdate :lua require('lb.utils.comment').copy_right_update()]]
end)
