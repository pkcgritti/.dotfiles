local runner = require('pkgrt.runner.scala')

vim.keymap.set('n', '<F5>', runner.execute_current_file)
vim.keymap.set('n', '<F6>', runner.execute_custom_class)
vim.keymap.set('n', '<F7>', runner.set_main_class_name)
vim.keymap.set('n', '<F8>', runner.get_main_class_name)
