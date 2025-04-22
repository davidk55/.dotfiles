-- =============== OPTIONS ===============
-- general
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2

-- =============== AUTOCOMMANDS ===============
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.java",
  callback = function()
    vim.opt_local.formatoptions = "jnqlr"
  end,
})

-- =============== MAPPINGS ===============
-- -- Diagnostics
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
-- GENERAL
vim.keymap.set(
  "n",
  "gr",
  "<cmd>Lspsaga finder<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Show search results" }
)
vim.keymap.set(
  "n",
  "<leader>ld",
  "<cmd>Lspsaga peek_definition<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Peek the definition" }
)
vim.keymap.set(
  "n",
  "<leader>lD",
  "<cmd>Lspsaga peek_type_definition<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Peek the type definition" }
)
vim.keymap.set(
  "n",
  "gd",
  "<cmd>Lspsaga goto_definition<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Go to the definition" }
)
vim.keymap.set(
  "n",
  "gD",
  "<cmd>Lspsaga goto_type_definition<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Go to type the definition" }
)
vim.keymap.set(
  "n",
  "K",
  "<cmd>Lspsaga hover_doc<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Show docs of under cursor" }
)
vim.keymap.set(
  "n",
  "<leader>K",
  "<cmd>Lspsaga hover_doc ++keep<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Toggle docs of under cursor" }
)
vim.keymap.set(
  "n",
  "<leader>rn",
  "<cmd>Lspsaga rename<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Rename under cursor" }
)
vim.keymap.set(
  "n",
  "<leader>la",
  "<cmd>Lspsaga code_action<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Code action with under cursor" }
)
vim.keymap.set(
  "n",
  "<leader>lo",
  "<cmd>Lspsaga outline<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[lsp] Outline treesitter in cur file" }
)
-- JAVA SPECIFIC
vim.keymap.set(
  "n",
  "<leader>jj",
  ":JavaRunnerToggleLogs<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] Toggle runner console" }
)
vim.keymap.set(
  "n",
  "<leader>jr",
  ":JavaRunnerRunMain<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] Run main" }
)
vim.keymap.set(
  "n",
  "<leader>jt",
  ":JavaTestRunCurrentMethod<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] Run current test method" }
)
vim.keymap.set(
  "n",
  "<leader>jT",
  ":JavaTestRunCurrentClass<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] Run current test class" }
)
vim.keymap.set(
  "n",
  "<leader>jl",
  ":JavaTestViewLastReport<CR>",
  { noremap = true, silent = true, buffer = true, desc = "[java] View last test results" }
)
-- CUSTOM
vim.keymap.set("n", "<leader>js", function()
  local line = vim.api.nvim_get_current_line()
  if string.find(line, "System") ~= nil then
    return "^df(<esc>$hx^"
  elseif string.sub(line, #line, #line) == ";" then
    return "ISystem.out.println(<esc>$i)<esc>^"
  else
    return "ISystem.out.println(<esc>$a);<esc>^"
  end
end, { expr = true, buffer = true, desc = "[java] Toggle print statement" })
