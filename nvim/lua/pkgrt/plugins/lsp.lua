local mylsp = require("pkgrt.lsp")
local utils = require("pkgrt.utils")


return {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        "folke/lazydev.nvim",

        -- Autocompletion
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip"
    },
    config = function()
        if vim.g.vscode then
            return
        end
        require("lazydev").setup({})
        require("mason-lspconfig").setup({
            automatic_enable = false,
            ensure_installed = {
                "clangd",
                "gopls",
                "lua_ls",
                "pyright",
                "rust_analyzer",
            },
        })

        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = {
                ["<C-Space>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.close()
                    else
                        cmp.complete()
                    end
                end, { "i", "c" }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
        })

        require("cmp_nvim_lsp").default_capabilities()

        local lspconfig = require("lspconfig")
        lspconfig.clangd.setup(mylsp.clangd)
        lspconfig.gopls.setup(mylsp.gopls)
        lspconfig.lua_ls.setup(mylsp.lua_ls)
        lspconfig.pyright.setup(mylsp.pyright)
        lspconfig.rust_analyzer.setup(mylsp.rust_analyzer)

        -- TODO: Precisamos checar aqui se estamos ou não no modo VSCode
        -- compatible antes de iniciar os language servers, para que nosso
        -- setup seja compatível com o utilizado no VSCode.
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, {
                        buffer = ev.buf,
                        desc = desc,
                    })
                end

                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                map("n", "gr", vim.lsp.buf.references, "Go to references")
                map("n", "K", vim.lsp.buf.hover, "Hover")
                map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, "Previous diagnostic")
                map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next diagnostic")
                map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
                map("n", "<leader>cf", vim.lsp.buf.format, "Format")
                map("n", "<leader>cd", vim.diagnostic.setqflist, "Show diagnostics buffer")

                map("n", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
                map("i", "<C-h>", vim.lsp.buf.signature_help, "Signature help")
                map("n", "<D-h>", vim.lsp.buf.signature_help, "Signature help")
                map("i", "<D-h>", vim.lsp.buf.signature_help, "Signature help")
            end
        })

        -- AutoCmd para mostrar diagnosticos
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
            end,
        })
    end,
}
