local remap = require("pkgrt.remap")



require("lazy").setup({
    spec = {

        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.4',
            lazy = false,
            config = remap.telescope, 
            dependencies = {
                {
                    'nvim-lua/plenary.nvim',
                    tag = 'v0.1.4'
                }
            }
        },

        {
            'rose-pine/neovim',
            name = 'rose-pine',
            lazy = false,
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        },

        {
            'nvim-treesitter/nvim-treesitter',
            tag = 'v0.9.1',
            lazy = false,
            config = function()
                require'nvim-treesitter.configs'.setup {
                    ensure_installed = { "python", "go", "c", "lua", "terraform", "scala", "vue" },
                    sync_install = false,
                    auto_install = false,
                    highlight = {
                        enable = true,
                        additional_vim_regex_highlighting = false,
                    },
                }
                vim.cmd('TSUpdate')
            end,
        },

        {
            'scalameta/nvim-metals',
            tag = 'v0.8.x',
            lazy = false,
            config = function()
                local api = vim.api
                local metals_config = require("metals").bare_config()
                local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
                api.nvim_create_autocmd("FileType", {
                    pattern = { "scala", "sbt", "java" },
                    callback = function()
                        require("metals").initialize_or_attach(metals_config)
                    end,
                    group = nvim_metals_group,
                })
            end,
            dependencies = {
                {
                    'nvim-lua/plenary.nvim',
                    tag = 'v0.1.4'
                },
                {
                    'mfussenegger/nvim-dap',
                    tag = '0.6.0',
                    config = function()
                        local dap = require("dap")
                        dap.configurations.scala = {
                            {
                                type = "scala",
                                request = "launch",
                                name = "RunOrTest",
                                metals = {
                                    runType = "runOrTestFile",
                                },
                            }
                        }
                    end,
                },
            }
        },

        {
            'numToStr/Comment.nvim',
            opts = {
                ignore = '^$',
            },
            lazy = false,
            tag = 'v0.8.0',
            config = remap.comment,
        },

        {
            'NeogitOrg/neogit',
            lazy = false,
            config = function()
                local neogit = require('neogit')
                neogit.setup({})
                vim.keymap.set("n", "<leader>xg", neogit.open)
            end,
        },

        {
            'jose-elias-alvarez/null-ls.nvim',
            branch = 'main',
            lazy = false,
            dependencies = {
                {
                    'nvim-lua/plenary.nvim',
                    tag = 'v0.1.4',
                }
            },
            config = function()
                local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
                local null_ls = require('null-ls')
                null_ls.setup({
                    sources = {
                        null_ls.builtins.formatting.black,
                        null_ls.builtins.formatting.isort,
                    },

                    on_attach = function(client, bufnr)
                        if client.supports_method("textDocument/formatting") then
                            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                            vim.api.nvim_create_autocmd("BufWritePre", {
                                group = augroup,
                                buffer = bufnr,
                                callback = function()
                                    vim.lsp.buf.format()
                                end,
                            })
                        end
                    end,
                })
            end,
        },

        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            lazy = false,
            dependencies = {
                { 'neovim/nvim-lspconfig', tag = 'v0.1.6' },
                { 'williamboman/mason.nvim', tag = 'v1.8.1' },
                { 'williamboman/mason-lspconfig.nvim', tag = 'v1.19.0' },
                -- Autocompletion
                { 'hrsh7th/nvim-cmp', branch = 'main' },
                { 'hrsh7th/cmp-buffer', branch = 'main' },
                { 'hrsh7th/cmp-path', branch = 'main' },
                { 'saadparwaiz1/cmp_luasnip', branch = 'master' },
                { 'hrsh7th/cmp-nvim-lsp', branch = 'main' },
                { 'hrsh7th/cmp-nvim-lua', branch = 'main' },
                -- Snippets
                { 'L3MON4D3/LuaSnip', tag = 'v2.0.0' },
                { 'rafamadriz/friendly-snippets', branch = 'main' },
            },
            config = function()
                local lsp = require('lsp-zero')

                lsp.preset('recommended')

                local cmp = require('cmp')
                local cmp_select = { behavior = cmp.SelectBehavior.Select }
                local cmp_mappings = lsp.defaults.cmp_mappings({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                })

                lsp.set_preferences({
                    sign_icons = {}
                })

                cmp.setup({
                    mapping = cmp_mappings
                })

                lsp.on_attach(function(client, bufnr)
                    local opts = { buffer = bufnr, remap = false }
                    vim.keymap.set({"n", "v"}, "J", "}zz", opts)
                    vim.keymap.set({"n", "v"}, "K", "{zz", opts)

                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definitions() end, opts)
                    vim.keymap.set("n", "<A-d>", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("n", "<leader>jd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set({"n", "i"}, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                    vim.keymap.set("n", "<C-f>", function () vim.lsp.buf.format() end, opts)
                    vim.keymap.set("n", "<leader>cf", function () vim.lsp.buf.format() end, opts)
                end)

                require('mason').setup({})
                require('mason-lspconfig').setup({
                    -- Replace the language servers listed here 
                    -- with the ones you want to install
                    ensure_installed = {
                        'gopls',
                        'tsserver', 
                        'rust_analyzer',
                        'pyright',
                        'taplo',
                        'volar',
                        'sqls',
                        'terraformls',
                    },

                    handlers = {
                      lsp.default_setup,
                      lua_ls = lsp.noop,
                      -- lua_ls = function ()
                      --     local lsp = require('lsp-zero')
                      --     local lua_opts = lsp.nvim_lua_ls()
                      --     require('lspconfig').lua_ls.setup(lua_opts)
                      -- end,
                    },

                })


            end,
        },
    },

    defaults = {
        lazy = true,
        -- version = false,
    },
})

