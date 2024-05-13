return {
  "karb94/neoscroll.nvim",
  config = function()
    -- =============== SETUP ===============
    require("neoscroll").setup({
      hide_cursor = false,
      respect_scrolloff = true,
    })
  end,
}
