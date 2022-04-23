local ns = { noremap = true, silent = true }
local n = { noremap = true }
local e = { expr = true}

-- *************************** WINDOWS *****************************
-- Split Windows
vim.keymap.set("n", "<leader>s", ":new<CR>", ns)
vim.keymap.set("n", "<leader>v", ":vnew<CR>", ns)

-- Move between windows
vim.keymap.set("n", "<leader>h", "<C-w>h", n)
vim.keymap.set("n", "<leader>j", "<C-w>j", n)
vim.keymap.set("n", "<leader>k", "<C-w>k", n)
vim.keymap.set("n", "<leader>l", "<C-w>l", n)

-- Move windows around
vim.keymap.set("n", "<leader>H", "<C-w>H", n)
vim.keymap.set("n", "<leader>J", "<C-w>J", n)
vim.keymap.set("n", "<leader>K", "<C-w>K", n)
vim.keymap.set("n", "<leader>L", "<C-w>L", n)

-- Resize windows
vim.keymap.set("n", "<leader><", "<C-w><", n)
vim.keymap.set("n", "<leader>>", "<C-w>>", n)
vim.keymap.set("n", "<leader>-", "<C-w>-", n)
vim.keymap.set("n", "<leader>+", "<C-w>+", n)
vim.keymap.set("n", "<leader>=", "<C-w>=", n)
vim.keymap.set("n", "<leader>_", "<C-w>_", n)

-- Quit window
vim.keymap.set("n", "<leader>q", "<C-w>q", n)

-- *************************** TABS ******************************
vim.keymap.set("n", "<leader>t", ":tabedit<CR>", ns)

-- *************************** WRITING/CLOSING ******************************
vim.keymap.set("n", "<leader>w", ":w", n)
vim.keymap.set("n", "<leader>!", "ZQ", n)


-- *************************** COPY/PASTE ******************************
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", n)
vim.keymap.set({"n", "v"}, "<leader>p", "\"+p", n)

-- *************************** DELETING ******************************
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d", n)


-- *************************** SEARCHING ******************************
vim.keymap.set("n", "<leader>/", ":noh<CR>", ns)

-- *************************** LIGHT/DARK TOGGLE ******************************
vim.keymap.set("n", "<leader>0", function()
  if (vim.o.background == "dark") then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, n)
