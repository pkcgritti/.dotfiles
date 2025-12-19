return {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.2',
    lazy = false,
    config = function()
        require('nvim-treesitter.configs').setup({
            auto_install = false,
            ignore_install = {},
            modules = {},
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "cmake",
                "diff",
                "go",
                "html",
                "lua",
                "luadoc",
                "python",
                "scala",
                "terraform",
                "vim",
                "vimdoc",
                "vue",
            },
            sync_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = { "c", "cpp" },
            },
        })
        vim.cmd('TSUpdate')
    end,
}
