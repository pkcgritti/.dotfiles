local M = {}

function M.run_tests()
    vim.api.nvim_command([[!go test ./...]])
end

return M
