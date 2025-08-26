local runner = require("pkgrt.runner.go")

vim.keymap.set("n", "<leader>pt", runner.run_tests)
