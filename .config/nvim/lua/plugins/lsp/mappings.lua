-- Diagnostics
vim.keymap.set(
  "n",
  "[r",
  "<cmd>Lspsaga diagnostic_jump_prev<CR>",
  { noremap = true, desc = "[lsp] Jump to next diagnostic" }
)
vim.keymap.set(
  "n",
  "]r",
  "<cmd>Lspsaga diagnostic_jump_next<CR>",
  { noremap = true, desc = "[lsp] Jump to prev diagnostic" }
)
vim.keymap.set(
  "n",
  "<leader>rr",
  "<cmd>Trouble document_diagnostics<CR>",
  { noremap = true, desc = "[lsp] Show list of diagnostics in file" }
)
vim.keymap.set(
  "n",
  "<leader>rw",
  "<cmd>Trouble workspace_diagnostics<CR>",
  { noremap = true, desc = "[lsp] Show list of diagnostics in workspace" }
)
vim.keymap.set(
  "n",
  "<leader>rl",
  "<cmd>Lspsaga show_line_diagnostics<CR>",
  { noremap = true, desc = "[lsp] Show diagnostics in current line" }
)

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- General
  vim.keymap.set(
    "n",
    "gr",
    "<cmd>Lspsaga finder<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Show search results" }
  )
  vim.keymap.set(
    "n",
    "<leader>ld",
    "<cmd>Lspsaga peek_definition<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Peek the definition" }
  )
  vim.keymap.set(
    "n",
    "<leader>lD",
    "<cmd>Lspsaga peek_type_definition<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Peek the type definition" }
  )
  vim.keymap.set(
    "n",
    "gd",
    "<cmd>Lspsaga goto_definition<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Go to the definition" }
  )
  vim.keymap.set(
    "n",
    "gD",
    "<cmd>Lspsaga goto_type_definition<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Go to type the definition" }
  )
  vim.keymap.set(
    "n",
    "K",
    "<cmd>Lspsaga hover_doc<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Show docs of under cursor" }
  )
  vim.keymap.set(
    "n",
    "<leader>K",
    "<cmd>Lspsaga hover_doc ++keep<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Toggle docs of under cursor" }
  )
  vim.keymap.set(
    "n",
    "<leader>rn",
    "<cmd>Lspsaga rename<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Rename under cursor" }
  )
  vim.keymap.set(
    "n",
    "<leader>la",
    "<cmd>Lspsaga code_action<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Code action with under cursor" }
  )
  vim.keymap.set(
    "n",
    "<leader>o",
    "<cmd>Lspsaga outline<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "[lsp] Outline treesitter in cur file" }
  )
end

return on_attach
