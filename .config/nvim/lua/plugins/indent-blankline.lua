return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    -- =============== SETUP ===============
    require("ibl").setup({
      scope = { enabled = false },
    })
  end,
}
