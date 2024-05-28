-- =============== AUTOCOMMANDS ===============
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.c",
  callback = function()
    vim.opt_local.formatoptions = "jnqlr"
  end,
  desc = "Change the formatoptions to jnqlr for c files",
})
