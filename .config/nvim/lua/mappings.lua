local ns = { noremap = true, silent = true }
local n = { noremap = true }
local e = { expr = true }

-- *************************** COPY/PASTE ******************************
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', n)
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', n)
vim.keymap.set({ "n", "v" }, "<leader>P", '$"+p', n)

-- *************************** DELETING ******************************
vim.keymap.set({ "n", "v" }, ",d", '"_d', n)

-- *************************** SEARCHING ******************************
vim.keymap.set("n", "<leader>/", ":noh<CR>:echo ''<CR>", ns)

-- *************************** MOVING ******************************
vim.keymap.set("n", "<leader>j", ":m +1<CR>", ns)
vim.keymap.set("n", "<leader>k", ":m -2<CR>", ns)

-- *************************** Buffer ******************************
vim.keymap.set("n", "<A-n>", ":enew<CR>", ns)

-- *************************** LIGHT/DARK TOGGLE ******************************
vim.keymap.set("n", "<leader>0", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
end, n)

-- *************************** PACKER ******************************
vim.keymap.set("n", "<leader><leader>u", ":PackerSync<CR>", ns)

-- *************************** TELESCOPE ******************************
-- File Pickers
vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, n)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, n)

-- Vim Pickers
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, n)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, n)
vim.keymap.set("n", "<leader>f/", require("telescope.builtin").search_history, n)
vim.keymap.set("n", "<leader>f:", require("telescope.builtin").command_history, n)
vim.keymap.set("n", '<leader>f"', require("telescope.builtin").registers, n)
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").commands, n)
vim.keymap.set("n", "<leader>fk", require("telescope.builtin").keymaps, n)
vim.keymap.set("n", "<leader>fc", require("telescope.builtin").colorscheme, n)
vim.keymap.set("n", "<leader>fl", require("telescope.builtin").reloader, n)

-- Git Pickers
vim.keymap.set("n", ",fs", require("telescope.builtin").git_status, n)
vim.keymap.set("n", ",fh", require("telescope.builtin").git_commits, n)
vim.keymap.set("n", ",fc", require("telescope.builtin").git_bcommits, n)
vim.keymap.set("n", ",fb", require("telescope.builtin").git_branches, n)

-- Treesitter Picker
vim.keymap.set("n", "<leader>ft", require("telescope.builtin").treesitter, n)

-- Todo Picker
vim.keymap.set("n", "<leader>fd", ":TodoTelescope<CR>", ns)

-- Project Picker
vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", ns)

-- *************************** LUASNIP ******************************
local luasnip = require("luasnip")

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.tab_complete = function()
  if luasnip.expand_or_jumpable() then
    return t("<Plug>luasnip-expand-or-jump")
  else
    return t("<Tab>")
  end
end
_G.s_tab_complete = function()
  if luasnip.jumpable(-1) then
    return t("<Plug>luasnip-jump-prev")
  else
    return t("<S-Tab>")
  end
end

vim.keymap.set({ "i", "s" }, "<Tab>", "v:lua.tab_complete()", e)
vim.keymap.set({ "i", "s" }, "<S-Tab>", "v:lua.s_tab_complete()", e)
vim.keymap.set({ "i", "s" }, "<C-l>", "<Plug>luasnip-next-choice")

-- *************************** LIGHTSPEED ******************************
vim.keymap.set("n", "s", "<Plug>Lightspeed_s")
vim.keymap.set("n", "S", "<Plug>Lightspeed_S")

-- *************************** BARBAR ******************************
vim.keymap.set("n", "<leader>bb", ":BufferPick<CR>", ns)

vim.keymap.set("n", "<leader>bn", ":BufferOrderByBufferNumber<CR>", ns)
vim.keymap.set("n", "<leader>bl", ":BufferOrderByLanguage<CR>", ns)

vim.keymap.set("n", "<A-c>", ":BufferClose<CR>", ns)

vim.keymap.set("n", "<A-,>", ":BufferPrevious<CR>", ns)
vim.keymap.set("n", "<A-.>", ":BufferNext<CR>", ns)

vim.keymap.set("n", "<A-<>", ":BufferMovePrevious<CR>", ns)
vim.keymap.set("n", "<A->>", ":BufferMoveNext<CR>", ns)

-- *************************** NVIM-TREE ******************************
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", ns)

-- *************************** VIMTEX ******************************
vim.keymap.set("n", "<leader>ll", ":VimtexCompile<CR>", n)
vim.keymap.set("n", "<leader>lc", ":VimtexClean<CR>", n)

-- *************************** TOGGLETERM ******************************
vim.keymap.set("n", ",,g", ":lua _LAZYGIT_TOGGLE()<CR>", ns)
vim.keymap.set("n", "<leader><leader>n", ":lua _NODE_TOGGLE()<CR>", ns)
vim.keymap.set("n", "<leader><leader>l", ":lua _LUA_TOGGLE()<CR>", ns)
vim.keymap.set("n", "<leader><leader>j", ":lua _JAVA_TOGGLE()<CR>", ns)
vim.keymap.set("t", "<A-Esc>", "<C-\\><C-n>", n)

-- *************************** NVIM-UFO ******************************
vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
