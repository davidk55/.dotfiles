local ns = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ai", require("typescript").actions.addMissingImports, ns)
vim.keymap.set("n", "<leader>ri", require("typescript").actions.removeUnused, ns)
vim.keymap.set("n", "<leader>oi", require("typescript").actions.organizeImports, ns)
