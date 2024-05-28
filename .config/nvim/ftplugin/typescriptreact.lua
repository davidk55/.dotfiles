-- =============== AUTOCOMMANDS ===============
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.c",
  callback = function()
    vim.opt_local.formatoptions = "jnqlr"
  end,
  desc = "Change the formatoptions to jnqlr for typescriptreact files",
})

-- =============== MAPPINGS ===============
vim.keymap.set(
  "n",
  "tt",
  "<cmd>TSToolsAddMissingImports<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[ts-tools] Add missing imports" }
)
vim.keymap.set(
  "n",
  "to",
  "<cmd>TSToolsOrganizeImports<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[ts-tools] Organize imports" }
)
vim.keymap.set(
  "n",
  "tf",
  "<cmd>TSToolsFixAll<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[ts-tools] Fix all" }
)
vim.keymap.set(
  "n",
  "tr",
  "<cmd>TSToolsRenameFile<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[ts-tools] Rename file" }
)
vim.keymap.set(
  "n",
  "td",
  "<cmd>TSToolsGoToSourceDefinition<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[ts-tools] Go to source definition" }
)
vim.keymap.set(
  "n",
  "tu",
  "<cmd>TSToolsFileReferences<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[ts-tools] File references" }
)
