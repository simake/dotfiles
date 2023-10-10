local builtin = require('telescope.builtin')
vim.keymap.set('n', ',,f', builtin.find_files, {})
vim.keymap.set('n', ',g', builtin.live_grep, {})
vim.keymap.set('n', ',b', builtin.buffers, {})
vim.keymap.set('n', ',h', builtin.help_tags, {})

vim.keymap.set('n', ',f', builtin.git_files, {})

