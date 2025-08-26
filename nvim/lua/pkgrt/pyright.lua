local M = {}

local function filter_array_inplace(array, predicate)
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

local function not_accessed_predicate(diagnostic)
    if string.match(diagnostic.message, '"_.+" is not accessed') then
        return false
    end

    return true
end

local function dlib_unknown_predicate(diagnostic)
    if string.match(diagnostic.message, 'not a known attribute of module "dlib"') then
        return false
    end

    return true
end

local function name_mismatch_predicate(diagnostic)
    if string.match(diagnostic.message, 'name mismatch: base parameter is named') then
        return false
    end

    return true
end

local function custom_on_publish_diagnostics(a, params, client_id, c, _)
    filter_array_inplace(params.diagnostics, not_accessed_predicate)
    filter_array_inplace(params.diagnostics, dlib_unknown_predicate)
    filter_array_inplace(params.diagnostics, name_mismatch_predicate)
    vim.lsp.diagnostic.on_publish_diagnostics(a, params, client_id, c)
end

function M.setup(_client, _bufnr)
    -- local diagnostic = require("workspace-diagnostics")
    -- diagnostic.populate_workspace_diagnostics(client, bufnr)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(custom_on_publish_diagnostics, {})
end

return M
