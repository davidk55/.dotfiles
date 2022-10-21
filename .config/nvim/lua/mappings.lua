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
vim.keymap.set("n", "<leader>/", ":noh<CR>", ns)

-- *************************** MOVING ******************************
vim.keymap.set("n", "<leader>j", ":m +1<CR>", ns)
vim.keymap.set("n", "<leader>k", ":m -2<CR>", ns)

-- *************************** Buffer ******************************
vim.keymap.set("n", "<A-n>", ":enew<CR>", ns)

-- *************************** SOURCING ******************************
vim.keymap.set("n", "<leader><leader>s", ":so %<CR>", ns)

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
vim.keymap.set("n", "<leader>bb", "<Cmd>BufferPick<CR>", ns)

vim.keymap.set("n", "<leader>bn", "<Cmd>BufferOrderByBufferNumber<CR>", ns)
vim.keymap.set("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", ns)

vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", ns)

vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", ns)
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", ns)

vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", ns)
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", ns)

-- *************************** NVIM-TREE ******************************
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", ns)

-- *************************** CCC ******************************
vim.keymap.set("n", "<leader><leader>c", ":CccPick<CR>", ns)

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

-- *************************** VENN ******************************
-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == "nil" then
    vim.b.venn_enabled = true
    vim.cmd([[setlocal ve=all]])
    -- draw a line on HJKL keystokes
    vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", { noremap = true, buffer = 0 })
    vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", { noremap = true, buffer = 0 })
    vim.keymap.set("n", "L", "<C-v>l:VBox<CR>", { noremap = true, buffer = 0 })
    vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", { noremap = true, buffer = 0 })
    -- draw a box by pressing "f" with visual selection
    vim.keymap.set("v", "f", ":VBox<CR>", { noremap = true, buffer = 0 })
  else
    vim.cmd([[setlocal ve=]])
    vim.cmd([[mapclear <buffer>]])
    vim.b.venn_enabled = nil
  end
end
-- toggle keymappings for venn using <leader>v
vim.keymap.set("n", "<leader><leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
