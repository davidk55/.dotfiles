local ns = { noremap = true, silent = true }
vim.keymap.set("n", "[d", require("lspsaga.diagnostic").goto_prev, ns)
vim.keymap.set("n", "]d", require("lspsaga.diagnostic").goto_next, ns)
vim.keymap.set("n", "<leader>dd", "<cmd>Trouble document_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dw", "<cmd>Trouble workspace_diagnostics<CR>", ns)
vim.keymap.set("n", "<leader>dl", require("lspsaga.diagnostic").show_line_diagnostics, { silent = true,noremap = true })

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local nsb = { noremap = true, silent = true, buffer = bufnr }
  local action = require("lspsaga.action")
  vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", nsb)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, nsb)
  vim.keymap.set("n", "<leader>ld", require("lspsaga.definition").preview_definition, ns)
  vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references<CR>", ns)
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", nsb)
  vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", nsb)
  vim.keymap.set("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", nsb)
  vim.keymap.set("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", nsb)
  vim.keymap.set("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", nsb)
  vim.keymap.set("n", "<leader>D", "<cmd>Trouble lsp_type_definitions<CR>", nsb)
  vim.keymap.set("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').lsp_rename()<CR>", nsb)
  vim.keymap.set("n", "<leader>la", require("lspsaga.codeaction").code_action, nsb)
  vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", nsb)

  vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, { silent = true })
  vim.keymap.set("n", "<C-f>", function()
      action.smart_scroll_with_saga(1)
  end, { silent = true })
  vim.keymap.set("n", "<C-b>", function()
      action.smart_scroll_with_saga(-1)
  end, { silent = true })
end

return on_attach
