local runner = require('pkgrt.runner.python')

vim.keymap.set('n', '<F5>', runner.execute_current_file)
vim.keymap.set('n', '<F6>', runner.execute_custom_file)
vim.keymap.set('n', '<F7>', runner.run_tests)
vim.keymap.set('n', '<F8>', runner.run_tests_with_coverage)
vim.keymap.set('n', '<F9>', runner.set_file)
vim.keymap.set('n', '<F10>', runner.get_file)
