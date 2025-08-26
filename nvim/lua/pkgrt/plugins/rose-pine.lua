return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
        vim.cmd("colorscheme rose-pine")

        vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    end,
}
