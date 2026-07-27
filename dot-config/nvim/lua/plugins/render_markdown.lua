return {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        -- Default Nerd Font checkbox glyphs are thin and hard to tell apart;
        -- use higher-contrast icons instead.
        checkbox = {
            -- unchecked = { icon = '☐ ' },
            -- checked = { icon = '✓ ' },
            unchecked = { icon = '🔲 ' },
            -- checked = { icon = '🔳 ' },
            -- checked = { icon = '✔️ ' },
            -- unchecked = { icon = '⬜ ' },
            checked = { icon = '✅ ' },
            -- unchecked = { icon = '○ ' },
            -- checked = { icon = '⦿ ' },
            -- unchecked = { icon = '⚪ ' },
            -- checked = { icon = '🔘 ' },
        },
    },
}
