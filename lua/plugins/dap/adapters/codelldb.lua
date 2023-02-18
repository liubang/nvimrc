--=====================================================================
--
-- lldb.lua -
--
-- Created by liubang on 2023/02/19 02:13
-- Last Modified: 2023/02/19 02:13
--
--=====================================================================

return {
  id = "codelldb",
  type = "server",
  port = "${port}",
  executable = {
    command = "codelldb",
    args = { "--port", "${port}" },
  },
}
