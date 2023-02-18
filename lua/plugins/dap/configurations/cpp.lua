--=====================================================================
--
-- cpp.lua -
--
-- Created by liubang on 2023/02/18 21:37
-- Last Modified: 2023/02/18 21:37
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
  },
}
