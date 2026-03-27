return {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.10.0',
    lazy = false,
    config = function()
        require('nvim-treesitter.configs').setup({
            auto_install = false,
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
                "markdown",
                "markdown_inline",
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
            },
        })
    end,
}
