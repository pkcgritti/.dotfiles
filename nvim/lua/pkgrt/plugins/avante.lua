return {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    commit = "80f7079556c6acf3d3effa13c22f0e4fd00bcffd",

    ---@module 'avante'
    ---@type avante.Config
    opts = {
        instructions_file = "avante.md",
        provider = "openai",
        providers = {
            ["openai"] = {
                endpoint = "https://api.openai.com/v1",
                model = "gpt-4o",
                api_key_name = "OPENAI_API_KEY",
                timeout = 30000,
                extra_request_body = {
                    temperature = 0.3,
                    max_tokens = 8192,
                },
            },
        },
        acp_providers = {
            ["codex"] = {
                -- command = "npx @zed-industries/codex-acp",
                command = "npx",
                args = { "@zed-industries/codex-acp" },
                env = {
                    NODE_NO_WARNINGS = "1",
                },
            },
        }
    },

    dependencies = {
        "nvim-lua/plenary.nvim",
        { "MunifTanjim/nui.nvim", commit = "de740991c12411b663994b2860f1a4fd0937c130" },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
    }
}
