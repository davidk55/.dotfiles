local ns = { noremap = true, silent = true}
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", ns)
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", ns)
vim.keymap.set("n", "<leader>dl", "<cmd>Trouble<CR>", ns)
vim.keymap.set("n", "<leader>dd", "<cmd>Trouble document_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dw", "<cmd>Trouble workspace_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dl", "<cmd>Trouble loclist<CR>", ns)
vim.keymap.set("n", "<leader>dq", "<cmd>Trouble quickfix<CR>", ns)

local on_attach = function(_,bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local nsb = { noremap = true, silent = true, buffer = bufnr}
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", nsb)
  vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions<CR>", nsb)
  vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", ns)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", nsb)
  vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", nsb)
  vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", nsb)
  vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", nsb)
  vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", nsb)
  vim.keymap.set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", nsb)
  vim.keymap.set("n", "<leader>D", "<cmd>Trouble lsp_type_definitions<CR>", nsb)
  vim.keymap.set("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", nsb)
  vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", nsb)
  vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", nsb)
end

return on_attach
