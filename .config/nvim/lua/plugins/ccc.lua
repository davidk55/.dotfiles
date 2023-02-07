return {
  "https://github.com/uga-rosa/ccc.nvim",
  config = function()
    -- =============== MAPPING ===============
    vim.keymap.set("n", "<leader><leader>c", ":CccPick<CR>", { noremap = true, silent = true })
  end,
}
