local utils = require("pkgrt.utils")
local M = {
    ["clangd"] = {},
    ["gopls"] = {},
    ["lua_ls"] = {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    telemetry = { enable = false },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                },
            },
    },
    ["pyright"] = {
        ---@param client { config: { settings: { python: { pythonPath: string } } } } 
        on_init = function(client)
            client.config.settings.python.pythonPath = utils.find_python()
        end,
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "strict",
                },
            }
        }
    },
    ["rust_analyzer"] = {
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                checkOnSave = {
                    command = "clippy"
                },
            },
        },
    },
}

return M
