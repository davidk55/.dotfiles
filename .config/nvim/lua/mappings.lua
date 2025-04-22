-- *************************** COPY/PASTE ******************************
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true, desc = "Yank to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { noremap = true, desc = "Paste from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '$"+p', { noremap = true, desc = "Paste clipboard to end of the line" })
vim.keymap.set("n", "<C-p>", "o<C-r>+<Esc>", { noremap = true, desc = "Paste clipboard and go to next line" })

-- *************************** DELETING ******************************
vim.keymap.set({ "n", "v" }, ",d", '"_d', { noremap = true, desc = "Delete to black hole register" })

-- *************************** SEARCHING ******************************
vim.keymap.set("n", "<leader>/", ":noh<CR>", { noremap = true, silent = true, desc = "Cancel current search" })

-- *************************** MOVING ******************************
vim.keymap.set("n", "<A-j>", ":m +1<CR>", { noremap = true, silent = true, desc = "Swap with line below" })
vim.keymap.set("n", "<A-k>", ":m -2<CR>", { noremap = true, silent = true, desc = "Swap with line above" })

-- *************************** Buffer ******************************
vim.keymap.set("n", "<A-n>", ":enew<CR>", { noremap = true, silent = true, desc = "Create new buffer" })

-- *************************** SOURCING ******************************
vim.keymap.set("n", "<leader><leader>s", ":so %<CR>", { noremap = true, silent = true, desc = "Source current file" })

-- *************************** SPLITS ******************************
vim.keymap.set("n", "<C-q>", "<C-w>q", { noremap = true, desc = "Quit current window" })
vim.keymap.set("n", "<A-v>", ":vert sbprevious<CR>", { noremap = true, desc = "Open a vertical split" })
vim.keymap.set("n", "<A-s>", ":hor sbprevious<CR>", { noremap = true, desc = "Open a horizontal split" })

-- *************************** QUICKFIX LIST ******************************
vim.keymap.set("n", "<leader>q", ":copen<CR><C-w>k", { noremap = true, silent = true, desc = "[quickfixlist] Open" })
vim.keymap.set("n", "<leader>Q", ":cclose<CR>", { noremap = true, silent = true, desc = "[quickfixlist] Close" })
vim.keymap.set("n", "]q", ":cnext<CR>", { noremap = true, silent = true, desc = "[quickfixlist] Next item" })
vim.keymap.set("n", "[q", ":cprev<CR>", { noremap = true, silent = true, desc = "[quickfixlist] Previous item" })
vim.keymap.set("n", "]Q", ":cnext<CR>", { noremap = true, silent = true, desc = "[quickfixlist] Last item" })
vim.keymap.set("n", "[Q", ":cprev<CR>", { noremap = true, silent = true, desc = "[quickfixlist] First item" })

-- *************************** LIGHT/DARK TOGGLE ******************************
vim.keymap.set("n", "<leader>0", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, { noremap = true, desc = "Toggle dark mode" })

-- *************************** WORD WRAP TOGGLE ******************************
vim.keymap.set("n", "<leader>w", function()
  vim.o.wrap = not vim.o.wrap
end, { noremap = true, desc = "Toggle word wrap" })

-- *************************** FINISH STATEMENT/ARGUMENT ******************************
vim.keymap.set("i", ";;", function()
  local line = vim.api.nvim_get_current_line()
  if string.sub(line, #line, #line) == ";" then
    return "<Esc>$i"
  else
    return "<Esc>A;<CR>"
  end
end, { expr = true, desc = "Put ; at the end and go to next line" })
vim.keymap.set("i", ";:", function()
  local line = vim.api.nvim_get_current_line()
  if string.sub(line, #line, #line) == ";" then
    return "<Esc>$i"
  else
    return "<Esc>A;<ESC><CR>"
  end
end, { expr = true, desc = "Put ; at the end and go to next line" })

vim.keymap.set("i", ";)", function()
  local line = vim.api.nvim_get_current_line()
  if string.sub(line, #line, #line) == ";" then
    return "<Esc>$i"
  else
    return "<Esc>f)a "
  end
end, { expr = true, desc = "Put ; at the end and go to next line" })
vim.keymap.set("i", ";{", function()
  -- local line = vim.api.nvim_get_current_line()
  -- if string.sub(line, #line, #line) == ";" then
  --   return "<Esc>$i"
  -- else
  return "<Esc>A {<CR>}<Esc>O"
end, { expr = true, desc = "Put ; at the end and go to next line" })
vim.keymap.set(
  "i",
  ";,",
  "<Esc>/['\"]<CR>:noh<CR>a, ",
  { noremap = true, silent = true, desc = "Put a , after the next ' or \"" }
)

-- *************************** LAZY ******************************
vim.keymap.set("n", "<leader><leader>u", ":Lazy<CR>", { noremap = true, silent = true, desc = "[lazy] Open lazy" })
