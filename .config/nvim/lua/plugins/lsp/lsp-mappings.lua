local ns = { noremap = true, silent = true }
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", ns)
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", ns)
vim.keymap.set("n", "<leader>dd", "<cmd>Trouble document_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dw", "<cmd>Trouble workspace_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dl", "<cmd>Lspsaga show_line_diagnostics<CR>", ns)

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local nsb = { noremap = true, silent = true, buffer = bufnr }
  -- vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", nsb)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, nsb)
  vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", ns)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", nsb)
  vim.keymap.set("n", "<C-i>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", nsb)
  -- vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", nsb)
  -- vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", nsb)
  -- vim.keymap.set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", nsb)
  -- vim.keymap.set("n", "<leader>D", "<cmd>Trouble lsp_type_definitions<CR>", nsb)
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", nsb)
  -- vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga peek_definition<CR>", ns)
  vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", nsb)
  -- vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", nsb)
  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", nsb)

  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
  vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", ns)
end

return on_attach
