--=====================================================================
--
-- nvim-dap.lua -
--
-- Created by liubang on 2023/02/18 16:27
-- Last Modified: 2023/02/18 16:27
--
--=====================================================================

-- stylua: ignore start
return {
  {
    "rcarriga/nvim-dap-ui",
    opts = {
      expand_lines = true,
      icons = { expanded = "", collapsed = "", circular = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "o" },
        open = "<CR>",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    },
    config = function(_, opts)
      require("dapui").setup(opts)
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end

      dap.adapters.go = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'dlv',
          args = {'dap', '-l', '127.0.0.1:${port}'},
        }
      }

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug (from vscode-go)",
          request = "launch",
          showLog = false,
          program = "${file}",
        },
        {
          type = "go",
          name = "Test Current File",
          request = "launch",
          showLog = true,
          mode = "test",
          program = "${file}",
        },
        {
          type = "go",
          name = "Attach process",
          mode = "local",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
        {
          type = "go",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          showLog = true,
          program = "./${relativeFileDirname}",
        },
      }

      local breakpoint = {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      }

      local breakpoint_rejected = {
        text = "",
        texthl = "DiagnosticSignError",
        linehl = "",
        numhl = "",
      }

      local stopped = {
        text = "",
        texthl = "DiagnosticSignWarn",
        linehl = "Visual",
        numhl = "DiagnosticSignWarn",
      }

      vim.fn.sign_define("DapBreakpoint", breakpoint)
      vim.fn.sign_define("DapBreakpointRejected", breakpoint_rejected)
      vim.fn.sign_define("DapStopped", stopped)
    end,
    keys = {
      { "<leader>db",function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dc",function() require("dap").continue() end, desc = "Continue" },
      { "<leader>di",function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do",function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dB",function() require("dap").step_back() end, desc = "Step back" },
      { "<leader>dO",function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dq",function() require("dap").close() end, desc = "Quit" },
      { "<leader>dU",function() require("dapui").toggle() end, desc = "Toggle ui" },
    },
  },
}
