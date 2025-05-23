-- Copyright (c) 2024 The Authors. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

-- Authors: liubang (it.liubang@gmail.com)

return {
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
      },
    },
    specs = { { "nvim-tree/nvim-web-devicons", enabled = false, optional = true } },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
  {
    "echasnovski/mini.bufremove", -- {{{
    -- stylua: ignore
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
    -- }}}
  },
  {
    "echasnovski/mini.cursorword",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      require("mini.cursorword").setup({
        delay = 100,
      })
      vim.api.nvim_set_hl(0, "MiniCursorword", { fg = nil, bg = "#3b3b3b" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { fg = nil, bg = nil })
    end,
  },
  {
    "echasnovski/mini.comment",
    keys = {
      { "gc", mode = { "n", "x" }, desc = "Toggle line comment" },
      { "gcc", mode = "n", desc = "Toggle line comment" },
    },
    opts = {
      options = {
        -- Function to compute custom 'commentstring' (optional)
        custom_commentstring = nil,
        -- Whether to ignore blank lines when commenting
        ignore_blank_line = false,
        -- Whether to ignore blank lines in actions and textobject
        start_of_line = false,
        -- Whether to force single space inner padding for comment parts
        pad_comment_parts = true,
      },
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = "gc",
        -- Toggle comment on current line
        comment_line = "gcc",
        -- Toggle comment on visual selection
        comment_visual = "gc",
        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = "gc",
      },
    },
  },

  {
    "echasnovski/mini.align", -- {{{
    keys = {
      { "ga", mode = { "n", "x" } },
      { "gA", mode = { "n", "x" } },
    },
    opts = {
      mappings = {
        start = "ga",
        start_with_preview = "gA",
      },
      -- Default options controlling alignment process
      options = {
        split_pattern = "",
        justify_side = "left",
        merge_delimiter = "",
      },
      -- Default steps performing alignment (if `nil`, default is used)
      steps = {
        pre_split = {},
        split = nil,
        pre_justify = {},
        justify = nil,
        pre_merge = {},
        merge = nil,
      },
    },
    -- }}}
  },

  {
    "echasnovski/mini.surround", -- {{{
    keys = function(plugin, keys)
      -- Populate the keys based on the user's options
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      n_lines = 40,
      highlight_duration = 1000,
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
    -- }}}
  },
  {
    "echasnovski/mini.files",
    version = "*",
    opts = {
      -- Module mappings created only inside explorer.
      -- Use `''` (empty string) to not create one.
      mappings = {
        close = "q",
        go_in = "",
        go_in_plus = "l",
        go_out = "",
        go_out_plus = "h",
        mark_goto = "'",
        mark_set = "m",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
      -- General options
      options = {
        permanent_delete = true,
        use_as_default_explorer = false,
      },
      -- Customization of explorer windows
      windows = {
        preview = false,
        width_focus = 30,
        width_nofocus = 18,
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)
      local map_split = function(buf_id, lhs, direction, close_on_file)
        local rhs = function()
          local new_target_window
          local cur_target_window = require("mini.files").get_explorer_state().target_window
          if cur_target_window ~= nil then
            vim.api.nvim_win_call(cur_target_window, function()
              vim.cmd("belowright " .. direction .. " split")
              new_target_window = vim.api.nvim_get_current_win()
            end)
            require("mini.files").set_target_window(new_target_window)
            require("mini.files").go_in({ close_on_file = close_on_file })
          end
        end
        local desc = "Open in " .. direction .. " split"
        if close_on_file then
          desc = desc .. " and close"
        end
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          map_split(buf_id, "<C-s>", "horizontal", true)
          map_split(buf_id, "<C-v>", "vertical", true)
        end,
      })

      -- use :w to save filesystem change
      vim.api.nvim_create_autocmd("User", {
        pattern = { "MiniFilesBufferCreate", "MiniFilesBufferUpdate" },
        callback = function(ev)
          local buf_id = ev.data.buf_id
          vim.schedule(function()
            vim.api.nvim_set_option_value("buftype", "acwrite", { buf = ev.data.buf_id })
            vim.api.nvim_buf_set_name(buf_id, "MiniFiles_" .. buf_id)
            vim.api.nvim_create_autocmd("BufWriteCmd", {
              buffer = buf_id,
              callback = MiniFiles.synchronize,
            })
          end)
        end,
      })
    end,
    keys = {
      {
        "<leader>ft",
        function()
          if not MiniFiles.close() then
            MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
          end
        end,
        desc = "Toggle mini.files (Directory of Current File)",
      },
      {
        "<leader>fT",
        function()
          if not MiniFiles.close() then
            MiniFiles.open(vim.uv.cwd(), true)
          end
        end,
        desc = "Toggle mini.files (cwd)",
      },
    },
  },
}
