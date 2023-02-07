local ns = { noremap = true, silent = true }

-- Diagnostics
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", ns)
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", ns)
vim.keymap.set("n", "<leader>dd", "<cmd>Trouble document_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dw", "<cmd>Trouble workspace_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", ns)

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- GENERAL
  local nsb = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", nsb)
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", nsb)
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", nsb)
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", nsb)
  vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", nsb)
  vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", nsb)
end

return on_attach
