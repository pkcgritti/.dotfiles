local M = {}

-- set leader key
vim.g.mapleader = " "

-- open project explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move by paragraphs on normal and visual mode
vim.keymap.set({"n", "v"}, "J", "}zz")
vim.keymap.set({"n", "v"}, "K", "{zz")

-- reload current rc file
vim.keymap.set("n", "<leader>rc", ":source %<CR>")
vim.keymap.set("n", "<leader>rl", ":luafile %<CR>")

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
vim.keymap.set({"n", "i"}, "<A-bs>", "<C-w>")

function M.telescope()
    local builtin = require('telescope.builtin')
    vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
    vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
    vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>ph", builtin.help_tags, {})
end

function M.comment()
    vim.keymap.set('x', '<A-;>', '<Plug>(comment_toggle_linewise_visual)')
end

return M

