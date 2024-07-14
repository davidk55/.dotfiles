local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- =============== GENERAL ===============
  vim.keymap.set(
    "n",
    "gr",
    "<cmd>Lspsaga finder<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Show search results" }
  )
  vim.keymap.set(
    "n",
    "<leader>ld",
    "<cmd>Lspsaga peek_definition<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Peek the definition" }
  )
  vim.keymap.set(
    "n",
    "<leader>lD",
    "<cmd>Lspsaga peek_type_definition<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Peek the type definition" }
  )
  vim.keymap.set(
    "n",
    "gd",
    "<cmd>Lspsaga goto_definition<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Go to the definition" }
  )
  vim.keymap.set(
    "n",
    "gD",
    "<cmd>Lspsaga goto_type_definition<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Go to type the definition" }
  )
  vim.keymap.set(
    "n",
    "K",
    "<cmd>Lspsaga hover_doc<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Show docs of under cursor" }
  )
  vim.keymap.set(
    "n",
    "<leader>K",
    "<cmd>Lspsaga hover_doc ++keep<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Toggle docs of under cursor" }
  )
  vim.keymap.set(
    "n",
    "<leader>rn",
    "<cmd>Lspsaga rename<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Rename under cursor" }
  )
  vim.keymap.set(
    "n",
    "<leader>la",
    "<cmd>Lspsaga code_action<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Code action with under cursor" }
  )
  vim.keymap.set(
    "n",
    "<leader>lo",
    "<cmd>Lspsaga outline<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Outline treesitter in cur file" }
  )
  -- =============== DIAGNOSTICS ===============
  vim.keymap.set(
    "n",
    "[r",
    "<cmd>Lspsaga diagnostic_jump_prev<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Jump to next diagnostic" }
  )
  vim.keymap.set(
    "n",
    "]r",
    "<cmd>Lspsaga diagnostic_jump_next<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Jump to prev diagnostic" }
  )
  vim.keymap.set(
    "n",
    "<leader>rr",
    "<cmd>Trouble document_diagnostics<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Show list of diagnostics in file" }
  )
  vim.keymap.set(
    "n",
    "<leader>rw",
    "<cmd>Trouble workspace_diagnostics<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Show list of diagnostics in workspace" }
  )
  vim.keymap.set(
    "n",
    "<leader>rl",
    "<cmd>Lspsaga show_line_diagnostics<CR>",
    { noremap = true, buffer = bufnr, desc = "[lsp] Show diagnostics in current line" }
  )

  -- =============== NVIM-LINT ===============
  vim.keymap.set("n", "<leader>ll", function()
    if vim.b.is_linting_disabled then
      vim.b.is_linting_disabled = false
      require("utils").enable_linting()
      vim.notify("[nvim-lint] Enable Linting", vim.log.levels.INFO)
    else
      vim.b.is_linting_disabled = true
      require("utils").disable_linting()
      vim.notify("[nvim-lint] Disable Linting", vim.log.levels.INFO)
    end
  end, { noremap = true, buffer = bufnr, desc = "[nvim-lint] Toggle linting" })

  -- =============== CONFORM ===============
  vim.keymap.set("n", "<leader>lf", function()
    if vim.b.disable_autoformat then
      vim.b.disable_autoformat = false
      vim.notify("[conform] Enable Formatting", vim.log.levels.INFO)
    else
      vim.b.disable_autoformat = true
      vim.notify("[conform] Disable Formatting", vim.log.levels.INFO)
    end
  end, { noremap = true, buffer = bufnr, desc = "[conform] Toggle formatting" })

  -- =============== TELESCOPE ===============
  vim.keymap.set(
    "n",
    "<leader>ld",
    require("telescope.builtin").lsp_document_symbols,
    { noremap = true, buffer = bufnr, desc = "[telescope] Lsp document symbols" }
  )
  vim.keymap.set(
    "n",
    "<leader>lg",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    { noremap = true, buffer = bufnr, desc = "[telescope] Lsp grep workspace symbols" }
  )
  vim.keymap.set(
    "n",
    "<leader>li",
    require("telescope.builtin").lsp_implementations,
    { noremap = true, buffer = bufnr, desc = "[telescope] Lsp implementations" }
  )
end

return on_attach
