local M = {}

function M.run_tests()
    vim.api.nvim_command([[!go test ./...]])
end

function M.format_current_file()
    vim.api.nvim_command('!gofmt -w %')
end

function M.go_mod_tidy()
    vim.api.nvim_command('!go mod tidy')
end

return M
