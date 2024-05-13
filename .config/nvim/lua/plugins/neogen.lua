return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    -- =============== SETUP ===============
    require("neogen").setup({ snippet_engine = "luasnip" })
  end,
}
