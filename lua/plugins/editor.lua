--=====================================================================
--
-- editor.lua -
--
-- Created by liubang on 2023/05/12 14:16
-- Last Modified: 2023/05/12 14:16
--
--=====================================================================

return {
    {
        'andymass/vim-matchup', -- {{{
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            vim.g.matchup_matchparen_offscreen = {}
            vim.g.matchup_matchparen_deferred = 1
        end,
        -- }}}
    },

    {
        'RRethy/vim-illuminate', -- {{{
        event = { 'BufReadPost', 'BufNewFile' },
        opts = {
            delay = 200,
            under_cursor = true,
            large_file_cutoff = 2000,
            large_file_overrides = { providers = { 'lsp' } },
        },
        config = function(_, opts)
            require('illuminate').configure(opts)

            local function map(key, dir, buffer)
                vim.keymap.set('n', key, function()
                    require('illuminate')['goto_' .. dir .. '_reference'](false)
                end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. ' Reference', buffer = buffer })
            end

            map(']]', 'next')
            map('[[', 'prev')

            -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
            vim.api.nvim_create_autocmd('FileType', {
                callback = function()
                    local buffer = vim.api.nvim_get_current_buf()
                    map(']]', 'next', buffer)
                    map('[[', 'prev', buffer)
                end,
            })
        end,
        keys = {
            { ']]', desc = 'Next Reference' },
            { '[[', desc = 'Prev Reference' },
        },
        -- }}}
    },

    {
        'rainbowhxch/accelerated-jk.nvim', -- {{{
        keys = {
            { 'j', '<Plug>(accelerated_jk_gj)', mode = { 'n' }, desc = 'Accelerated gj movement' },
            { 'k', '<Plug>(accelerated_jk_gk)', mode = { 'n' }, desc = 'Accelerated gk movement' },
        },
        opts = {
            mode = 'time_driven',
            enable_deceleration = false,
            acceleration_motions = {},
            acceleration_limit = 150,
            acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
            deceleration_table = { { 150, 9999 } },
        },
        -- }}}
    },

    {
        'numToStr/Comment.nvim', -- {{{
        keys = {
            { 'gc', mode = { 'n', 'x' }, desc = 'Toggle line comment' },
            { 'gb', mode = { 'n', 'x' }, desc = 'Toggle block comment' },
            { 'gcc', mode = 'n', desc = 'Toggle line comment' },
            { 'gcb', mode = 'n', desc = 'Toggle block comment' },
        },
        opts = function()
            -- set rust comment string
            local ft = require 'Comment.ft'
            ft.set('rust', '///%s')

            return {
                padding = true,
                mappings = {
                    basic = true,
                    extra = false,
                },
            }
        end,
        -- }}}
    },

    {
        'iamcco/markdown-preview.nvim', -- {{{
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        keys = {
            {
                '<Leader>mp',
                '<CMD>MarkdownPreview<CR>',
                desc = 'Markdown Preview',
            },
        },
        -- }}}
    },

    {
        'saecki/crates.nvim', -- {{{
        event = { 'BufReadPre Cargo.toml' },
        opts = {
            popup = {
                autofocus = true,
            },
        },
        -- }}}
    },

    {
        'RaafatTurki/hex.nvim', -- {{{
        config = true,
        cmd = { 'HexToggle' },
        -- }}}
    },

    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
            {
                '<Leader>kk',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump {
                        search = { mode = 'search', max_length = 0 },
                        label = { after = { 0, 0 } },
                        pattern = '^',
                    }
                end,
            },
            {
                '<Leader>jj',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump {
                        search = { mode = 'search', max_length = 0 },
                        label = { after = { 0, 0 } },
                        pattern = '^',
                    }
                end,
            },
        },
    },

    { 'skywind3000/vim-flex-bison-syntax', ft = { 'yacc', 'lex' } },
}

-- vim: fdm=marker fdl=0
