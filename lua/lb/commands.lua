-- =====================================================================
--
-- commands.lua -
--
-- Created by liubang on 2020/12/12 18:32
-- Last Modified: 2022/12/31 22:29
--
-- =====================================================================

vim.api.nvim_create_user_command("Filepath", function() -- {{{
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.notify(vim.fn.expand("%:p"), vim.log.levels.INFO, {
    title = "Filename",
    timeout = 3000,
  })
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("YankFilename", function() -- {{{
  vim.fn.setreg('"', vim.fn.expand("%:t"))
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("YankFilepath", function() -- {{{
  vim.fn.setreg('"', vim.fn.expand("%:p"))
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("CopyRight", function() -- {{{
  require("lb.utils.comment").copy_right()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("CopyRightApache", function() -- {{{
  require("lb.utils.comment").copy_right_apache()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("TrimWhiteSpace", function() -- {{{
  require("lb.utils.util").trim_whitespace()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("P", function(obj) -- {{{
  vim.pretty_print(vim.fn.luaeval(obj.args))
end, { nargs = 1 }) -- }}}

vim.api.nvim_create_user_command("DocUpdate", function() -- {{{
  require("lb.utils.doc").update()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("Tasks", function() -- {{{
  require("telescope").extensions.tasks.tasks()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("BazelBuild", function() -- {{{
  require("telescope").extensions.bazel.bazel_build()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("BazelRun", function() -- {{{
  require("telescope").extensions.bazel.bazel_run()
end, { nargs = 0 }) -- }}}

vim.api.nvim_create_user_command("BazelTests", function() -- {{{
  require("telescope").extensions.bazel.bazel_tests()
end, { nargs = 0 }) -- }}}

-- vim: fdm=marker fdl=0
