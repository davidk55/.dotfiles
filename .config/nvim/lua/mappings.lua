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

-- *************************** TELESCOPE ******************************
-- File Pickers
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, n)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, n)

-- Vim Pickers
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, n)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, n)
vim.keymap.set("n", "<leader>f/", require("telescope.builtin").search_history, n)
vim.keymap.set("n", "<leader>f:", require("telescope.builtin").command_history, n)
vim.keymap.set("n", "<leader>f\"", require("telescope.builtin").registers, n)
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").commands, n)
vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps, n)
vim.keymap.set("n", "<leader>fc", require("telescope.builtin").colorscheme, n)
vim.keymap.set("n", "<leader>fl", require("telescope.builtin").reloader, n)


-- Git Pickers
vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status, n)
vim.keymap.set("n", "<leader>gc", require("telescope.builtin").git_commits, n)
vim.keymap.set("n", "<leader>gh", require("telescope.builtin").git_bcommits, n)
vim.keymap.set("n", "<leader>gb", require("telescope.builtin").git_branches, n)

-- Treesitter Picker
vim.keymap.set("n", "<leader>ft", require("telescope.builtin").treesitter, n)

-- Todo Picker
vim.keymap.set("n", "<leader>fd", ":TodoTelescope<CR>", n)
