return {
    -- Markdown renderer, used by `Avante` plugin
    {
        'MeanderingProgrammer/render-markdown.nvim',
        tag = "v8.10.0",
        opts = {
            file_types = { "markdown", "md", "Avante" },
        },
        ft = { "markdown", "md", "Avante" },
    },
    -- Check the stevearc/aerial.nvim plugin. Maybe it is a good one
    -- for navigation on markdown and also on source codes
    {
        'stevearc/aerial.nvim',
        tag = "v2.6.1",
    },
}
