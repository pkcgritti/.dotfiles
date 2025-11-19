local M = {}

M.file = nil

function M.execute_current_file()
    vim.api.nvim_command('!python %')
end

function M.format_current_file()
    vim.api.nvim_command('!black %')
end

function M.isort_current_file()
    vim.api.nvim_command('!isort %')
end

function M.execute_custom_file()
    vim.api.nvim_command([[!python ]] .. M.file)
end

function M.run_tests()
    vim.api.nvim_command('!pytest')
end

function M.run_tests_with_coverage()
    vim.api.nvim_command('!pytest --cov')
end

function M.run_diagnostics()
    vim.api.nvim_command([[!pyright -v ]] .. os.getenv("HOME") .. "/.virtualenvs")
end

function M.set_file()
    local file = vim.fn.input("Python file: ", "", "file")
    M.file = file
end

function M.get_file()
    print(M.file)
end

return M
