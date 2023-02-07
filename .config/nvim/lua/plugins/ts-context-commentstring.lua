return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  ft = { "typescript", "typescriptreact" },
  config = function()
    -- =============== SETUP ===============
    require("nvim-treesitter.configs").setup({
      context_commentstring = {
        enable = true,
      },
    })
  end,
}
