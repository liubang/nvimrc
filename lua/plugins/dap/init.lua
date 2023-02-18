--=====================================================================
--
-- init.lua -
--
-- Created by liubang on 2023/02/18 21:26
-- Last Modified: 2023/02/18 21:26
--
--=====================================================================

return {
  {
    "rcarriga/nvim-dap-ui",
    config = function(_, _)
      require "plugins.dap.ui"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      require "plugins.dap.dap"
    end,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>dB",
        function()
          require("dap").step_back()
        end,
        desc = "Step back",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dq",
        function()
          require("dap").close()
        end,
        desc = "Quit",
      },
      {
        "<leader>dU",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle ui",
      },
    },
  },
}
