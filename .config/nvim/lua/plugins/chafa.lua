return {
  "princejoogie/chafa.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "m00qek/baleia.nvim",
  },
  config = function()
    -- =============== SETUP ===============
    require("chafa").setup({
      render = {
        show_label = false,
      },
    })
    -- =============== MAPPING ===============
    vim.keymap.set("n", "<A-i>", ":ViewImage<CR>", { noremap = true, silent = true })
  end,
}
