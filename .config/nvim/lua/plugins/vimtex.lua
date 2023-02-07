return {
  "lervag/vimtex",
  ft = { "tex" },
  config = function()
    -- =============== MAPPINGS ===============
    vim.keymap.set("n", "<leader>ll", ":VimtexCompile<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>lc", ":VimtexClean<CR>", { noremap = true })

    -- =============== OPTIONS ===============
    vim.g.vimtex_view_method = "sioyek"
    vim.g.tex_flavor = "latex" -- Make .tex files indentified as LaTeX by default
  end,
}
