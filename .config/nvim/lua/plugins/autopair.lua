return {
  "windwp/nvim-autopairs",
  config = function()
    -- =============== SETUP ===============
    require("nvim-autopairs").setup({
      disable_in_macro = true, -- disable when recording or executing a macro
    })
  end,
}
