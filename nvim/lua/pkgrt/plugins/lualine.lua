return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',
                icons_enabled = true,
                globalstatus = true,
            },
        })
    end,
    -- config = function()
    --     require('lualine').setup({
    --         options = {
    --             theme = 'auto',
    --             icons_enabled = true,
    --             component_separators = { left = '?', right = '?' },
    --             section_separators = { left = '?', right = '?' },
    --             globalstatus = true,
    --         },
    --
    --         sections = {
    --             lualine_a = { 'mode' },
    --             lualine_b = { 'branch', 'diff' },
    --             lualine_c = { { 'filename', path = 1 } },
    --             lualine_x = { 'encoding', 'fileformat', 'filetype' },
    --             lualine_y = { 'progress' },
    --             lualine_z = { 'location' },
    --         },
    --     })
    -- end
}
