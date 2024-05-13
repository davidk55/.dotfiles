return {
  "uga-rosa/ccc.nvim",
  config = function()
    -- =============== SETUP ===============
    require("ccc").setup()

    -- =============== MAPPING ===============
    vim.keymap.set("n", "<leader><leader>c", ":CccPick<CR>", { noremap = true, silent = true })
  end,
}
