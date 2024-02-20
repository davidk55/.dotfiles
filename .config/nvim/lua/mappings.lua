local ns = { noremap = true, silent = true }
local n = { noremap = true }

-- *************************** COPY/PASTE ******************************
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', n)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', n)
vim.keymap.set({ "n", "v" }, "<leader>P", '$"+p', n)

-- *************************** DELETING ******************************
vim.keymap.set({ "n", "v" }, ",d", '"_d', n)

-- *************************** SEARCHING ******************************
vim.keymap.set("n", "<leader>/", ":noh<CR>", ns)

-- *************************** MOVING ******************************
vim.keymap.set("n", "<leader>j", ":m +1<CR>", ns)
vim.keymap.set("n", "<leader>k", ":m -2<CR>", ns)

-- *************************** Buffer ******************************
vim.keymap.set("n", "<A-n>", ":enew<CR>", ns)

-- *************************** SOURCING ******************************
vim.keymap.set("n", "<leader><leader>s", ":so %<CR>", ns)

-- *************************** SPLITS ******************************
vim.keymap.set("n", "<C-q>", "<C-w>q", n)
vim.keymap.set("n", "<A-v>", ":vert sbprevious<CR>", n)
vim.keymap.set("n", "<A-s>", ":hor sbprevious<CR>", n)

-- *************************** LIGHT/DARK TOGGLE ******************************
vim.keymap.set("n", "<leader>0", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, n)

-- *************************** WORD WRAP TOGGLE ******************************
vim.keymap.set("n", "<leader>w", function()
  vim.o.wrap = not vim.o.wrap
end, n)

-- *************************** FINISH STATEMENT ******************************
vim.keymap.set("i", "<C-;>", "<ESC>$a;<ESC>o", n)

-- *************************** LAZY ******************************
vim.keymap.set("n", "<leader><leader>u", ":Lazy<CR>", ns)
