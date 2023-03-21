return {
  "karb94/neoscroll.nvim",
  enabled = true,
  config = function()
    require("neoscroll").setup({
      hide_cursor = false,
      respect_scrolloff = true,
    })
  end,
}
