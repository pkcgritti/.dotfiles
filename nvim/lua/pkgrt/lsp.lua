local utils = require("pkgrt.utils")
local remap = require("pkgrt.remap")

local M = {
    ["clangd"] = {},

    ["gopls"] = {
        on_init = function(client)
            remap.go_mode()
        end,
    },

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
            client.notify('workspace/didChangeConfiguration')
            remap.python_mode()
        end,
        settings = {
            python = {
                analysis = {
                    -- Desabilita análise de libs externas (acelera imports como numpy/tensorflow)
                    useLibraryCodeForTypes = false,
                    autoSearchPaths = false,
                    diagnosticMode = "openFilesOnly",
                    diagnosticSeverityOverrides = {
                        reportImportCycles = 'none',
                        reportUndefinedVariable = 'warning',
                        reportOptionalMemberAccess = 'none',
                        reportOptionalIterable = 'none',
                        reportOptionalContextManager = 'none',
                        reportOptionalOperand = 'none',
                        reportUntypedFunctionDecorator = 'none',
                        reportUntypedClassDecorator = 'none',
                        reportUntypedBaseClass = 'none',
                        reportUntypedNamedTuple = 'none',
                        reportPrivateUsage = 'none',
                        reportConstantRedefinition = 'none',
                        reportIncompatibleMethodOverride = 'none',
                        reportIncompatibleVariableOverride = 'none',
                    },
                    stubPath = vim.fn.stdpath('cache') .. '/pyright-stubs', -- cria pasta de stubs
                    typeCheckingMode = "strict",
                },
            },
        },
        flags = {
            debounce_text_changes = 200,
        },
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
