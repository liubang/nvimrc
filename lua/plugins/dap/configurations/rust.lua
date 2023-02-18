--=====================================================================
--
-- rust.lua -
--
-- Created by liubang on 2023/02/19 02:22
-- Last Modified: 2023/02/19 02:22
--
--=====================================================================

return {
  {
    name = "Launch file (lldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}
