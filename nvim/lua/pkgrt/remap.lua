local M = {}

-- set leader key
vim.g.mapleader = " "

-- open project explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move by paragraphs on normal and visual mode
-- vim.keymap.set({ "n", "v" }, "J", "}zz")
-- vim.keymap.set({ "n", "v" }, "K", "{zz")

-- reload current rc file
vim.keymap.set("n", "<leader>rc", ":source %<CR>")
vim.keymap.set("n", "<leader>rl", ":luafile %<CR>")
vim.keymap.set("n", "<leader>re", ":edit " .. vim.fn.stdpath('config') .. "/init.lua<CR>")
vim.keymap.set("n", "<leader>rm", ":edit " .. vim.fn.stdpath('config') .. "/lua/pkgrt/remap.lua<CR>")
vim.keymap.set("n", "<leader>rp", ":edit " .. vim.fn.stdpath('config') .. "/lua/pkgrt<CR>")
vim.keymap.set("n", "<leader>rr", function()
    local reloadset = {
        "/lua/pkgrt/remap.lua",
        "/lua/pkgrt/set.lua",
        "/lua/pkgrt/utils.lua",
    }
    for _, mod in pairs(reloadset) do
        dofile(vim.fn.stdpath('config') .. mod)
    end
    print("Neovim config reloaded!")
end)

-- buffer utilities
vim.keymap.set("n", "<leader>bd", ":bd<CR>")
vim.keymap.set("n", "<leader>bn", ":bn<CR>")

-- escape with jk
vim.keymap.set("i", "jk", "<ESC>")

-- join lines
vim.keymap.set("n", "<leader>lj", "J")

-- show docs
vim.keymap.set("n", "<C-h>", "K")
vim.keymap.set("n", "<leader>vh", ":help <C-r><C-w><CR>")

-- move blocks on visual mode
vim.keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")

-- window commands
vim.keymap.set("n", "<leader>ws", ":split<CR>")
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>wr", "<C-w><C-r>")
vim.keymap.set("n", "<leader>ww", "<C-w><C-w>")
vim.keymap.set("n", "<leader>wh", "<C-w><C-h>")
vim.keymap.set("n", "<leader>wj", "<C-w><C-j>")
vim.keymap.set("n", "<leader>wk", "<C-w><C-k>")
vim.keymap.set("n", "<leader>wl", "<C-w><C-l>")
vim.keymap.set("n", "<leader>wq", ":q<CR>")

-- remove unused key bindings
vim.keymap.set("n", "Q", "<nop>")

-- copy to clipboard
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>Y", "\"+y")

-- center buffer on search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- delete word backwards
vim.keymap.set({ "n", "i" }, "<A-bs>", "<C-w>")
vim.keymap.set({ "n", "i" }, "<D-bs>", "<C-w>")

-- telescope remappings
function M.telescope()
    local builtin = require('telescope.builtin')
    vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
    vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
    vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})
end

-- neogit remappings
function M.neogit()
    local neogit = require('neogit')
    vim.keymap.set("n", "<leader>xg", neogit.open)
end

-- lsp remappings
function M.lsp(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    -- vim.keymap.set({ "n", "v" }, "J", "}zz", opts)
    -- vim.keymap.set({ "n", "v" }, "K", "{zz", opts)

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definitions() end, opts)
    vim.keymap.set("n", "<A-d>", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<D-d>", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>h", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>crr", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>jd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set({ "n", "i" }, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set({ "n", "i" }, "<D-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<C-f>", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, opts)
    vim.keymap.set("n", "<leader>cd", function() vim.diagnostic.setqflist() end, opts)
end

-- python mode remappings
function M.python_mode()
    local runner = require('pkgrt.runner.python')
    -- local diagnostic = require('workspace-diagnostics')

    vim.keymap.set("n", "<leader>ff", runner.format_current_file)
    vim.keymap.set("n", "<leader>fs", runner.isort_current_file)

    vim.keymap.set("n", "<F5>", runner.execute_current_file)
    vim.keymap.set("n", "<leader>fe", runner.execute_current_file)
    vim.keymap.set("n", "<leader>fr", runner.execute_current_file)

    vim.keymap.set("n", "<F6>", runner.execute_custom_file)
    vim.keymap.set("n", "<leader>fc", runner.execute_custom_file)

    vim.keymap.set("n", "<F7>", runner.run_tests)
    vim.keymap.set("n", "<leader>pt", runner.run_tests)

    -- vim.keymap.set("n", "<leader>pd", function()
    --     for _, client in ipairs(vim.lsp.get_clients()) do
    --         diagnostic.populate_workspace_diagnostics(client, 0)
    --     end
    -- end)

    vim.keymap.set("n", "<F8>", runner.run_tests_with_coverage)
    vim.keymap.set("n", "<leader>pc", runner.run_tests_with_coverage)

    vim.keymap.set("n", "<F9>", runner.set_file)
    vim.keymap.set("n", "<leader>fS", runner.set_file)

    vim.keymap.set("n", "<F10>", runner.get_file)
    vim.keymap.set("n", "<leader>fG", runner.get_file)
end

function M.go_mode()
    local runner = require('pkgrt.runner.go')

    vim.keymap.set("n", "<leader>ff", runner.format_current_file)
    vim.keymap.set("n", "<leader>fs", runner.go_mod_tidy)
end

-- toogle comments
function M.comment()
    vim.keymap.set('x', '<leader>tc', '<Plug>(comment_toggle_linewise_visual)')
    vim.keymap.set('x', '<A-;>', '<Plug>(comment_toggle_linewise_visual)')
    vim.keymap.set('x', '<D-;>', '<Plug>(comment_toggle_linewise_visual)')
end

return M
