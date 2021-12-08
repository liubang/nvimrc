-- =====================================================================
--
-- comment.lua -
--
-- Created by liubang on 2021/08/31 22:41
-- Last Modified: 2021/08/31 22:41
--
-- =====================================================================

return function()
  require('Comment').setup {
    ignore = nil,

    ---LHS of toggle mappings in NORMAL + VISUAL mode
    ---@type table
    toggler = {
      ---line-comment keymap
      line = 'gcc',
      ---block-comment keymap
      block = 'gbc',
    },

    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    ---@type table
    opleader = {
      ---line-comment keymap
      line = 'gc',
      ---block-comment keymap
      block = 'gb',
    },

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---@type table
    mappings = {
      ---operator-pending mapping
      ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
      ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
      basic = true,
      ---extra mapping
      ---Includes `gco`, `gcO`, `gcA`
      extra = false,
      ---extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
    },

    ---Pre-hook, called before commenting the line
    ---@type fun(ctx: Ctx):string
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    ---@type fun(ctx: Ctx)
    post_hook = nil,
  }
end
