return {
  "roobert/tailwindcss-colorizer-cmp.nvim",
  ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  config = function()
    -- =============== SETUP ===============
    require("tailwindcss-colorizer-cmp").setup()
  end,
}
