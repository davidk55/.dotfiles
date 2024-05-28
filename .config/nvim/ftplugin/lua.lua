vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.lua",
  callback = function()
    vim.opt_local.formatoptions = "jnqlr"
  end,
  desc = "Change the formatoptions to jnqlr for lua files",
})

vim.keymap.set(
  "n",
  "<F9>",
  ':lua require("osv").run_this()<CR>',
  { noremap = true, silent = true, buffer = true, desc = "[dap] Start the lua debugger" }
)
vim.keymap.set(
  "n",
  "<F10>",
  ':lua require("osv").stop()<CR>',
  { noremap = true, silent = true, buffer = true, desc = "[dap] Stop the lua debugger" }
)
