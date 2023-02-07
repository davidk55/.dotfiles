local ns = { noremap = true, silent = true }

vim.bo.formatoptions = "jnqlr"

vim.keymap.set("n", "<leader>rr", require("typescript").actions.addMissingImports, ns)
vim.keymap.set("n", "<leader>ru", require("typescript").actions.removeUnused, ns)
vim.keymap.set("n", "<leader>ro", require("typescript").actions.organizeImports, ns)
