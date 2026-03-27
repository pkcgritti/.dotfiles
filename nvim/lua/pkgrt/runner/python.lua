local M = {}

M.file = nil
M.formatter_cache = nil

-- Detecta qual formatter está disponível no ambiente
local function detect_formatter()
    if M.formatter_cache then
        return M.formatter_cache
    end

    if vim.fn.executable('ruff') == 1 then
        M.formatter_cache = 'ruff'
        return 'ruff'
    end

    if vim.fn.executable('black') == 1 and vim.fn.executable('isort') == 1 then
        M.formatter_cache = 'black+isort'
        return 'black+isort'
    end

    M.formatter_cache = 'none'
    return 'none'
end

function M.execute_current_file()
    vim.api.nvim_command('!python %')
end

function M.format_current_file()
    local formatter = detect_formatter()
    
    if formatter == 'ruff' then
        -- Organiza imports, remove não usados e formata o código
        vim.api.nvim_command('!ruff check --fix --select I,F401 % && ruff format %')
    elseif formatter == 'black+isort' then
        vim.api.nvim_command('!black % && isort %')
    else
        vim.api.nvim_err_writeln('Error: No formatter found. Please install ruff or black+isort')
    end
end

function M.isort_current_file()
    local formatter = detect_formatter()
    
    if formatter == 'ruff' then
        -- Quando ruff está disponível, fs e ff fazem a mesma coisa
        vim.api.nvim_command('!ruff check --fix --select I,F401 % && ruff format %')
    elseif formatter == 'black+isort' then
        vim.api.nvim_command('!isort %')
    else
        vim.api.nvim_err_writeln('Error: No formatter found. Please install ruff or black+isort')
    end
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
