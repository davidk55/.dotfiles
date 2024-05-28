return {
  "stevearc/oil.nvim",
  config = function()
    -- =============== SETUP ===============
    require("oil").setup()
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "[oil] Open the parent directory" })
  end,
}
