local M = {}

function M.get_cwd_basename()
    return vim.fs.basename(vim.fn.getcwd())
end

function M.find_python()
    local currentDir = M.get_cwd_basename()
    -- 1. Tenta virtualenv do projeto
    local projectPath = vim.fn.expand("$HOME/.virtualenvs/" .. currentDir .. "/bin/python")
    if vim.fn.filereadable(projectPath) == 1 then
        return projectPath
    end
    -- 2. Tenta VIRTUAL_ENV
    if vim.env.VIRTUAL_ENV then
        local venv_python = vim.env.VIRTUAL_ENV .. "/bin/python"
        if vim.fn.filereadable(venv_python) == 1 then
            return venv_python
        end
    end
    -- 3. Tenta CONDA_PREFIX
    if vim.env.CONDA_PREFIX then
        local conda_python = vim.env.CONDA_PREFIX .. "/bin/python"
        if vim.fn.filereadable(conda_python) == 1 then
            return conda_python
        end
    end
    -- 4. Tenta poetry
    local poetry_python = vim.fn.system("poetry env info -p 2>/dev/null")
    poetry_python = vim.fn.trim(poetry_python)
    if poetry_python ~= "" then
        local poetry_bin = poetry_python .. "/bin/python"
        if vim.fn.filereadable(poetry_bin) == 1 then
            return poetry_bin
        end
    end
    -- 5. Tenta base
    local basePath = vim.fn.expand("$HOME/.virtualenvs/base/bin/python")
    if vim.fn.filereadable(basePath) == 1 then
        return basePath
    end
    -- 6. Fallback: python3 do sistema
    return vim.fn.exepath("python3") or "python"
end

function M.filter_array_inplace(array, predicate)
    local new_index = 1
    local size_orig = #array
    for old_index, value in ipairs(array) do
        if predicate(value, old_index) then
            array[new_index] = value
            new_index = new_index + 1
        end
    end
    for i = new_index, size_orig do array[i] = nil end
end

return M
