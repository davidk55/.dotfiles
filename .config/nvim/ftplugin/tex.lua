-- =============== OPTIONAS ===============
vim.bo.softtabstop = 4
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.g.vimtex_view_method = "sioyek"
vim.g.tex_flavor = "latex" -- make `.tex` files indentified as LaTeX by default
vim.g.vimtex_syntax_enabled = 0 -- disable message `using treesitter syntax`
vim.opt.cmdheight = 2 -- remove `Hit ENTER to continue...` prompt

-- =============== MAPPINGS ===============
vim.keymap.set("n", "<leader>l", ":VimtexCompile<CR>", { noremap = true, buffer = true, silent = true })
vim.keymap.set("n", "<leader>c", ":VimtexClean<CR>", { noremap = true, buffer = true, silent = true })
