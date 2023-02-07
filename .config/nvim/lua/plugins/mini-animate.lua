return {
  "echasnovski/mini.animate",
  enabled = false,
  config = function()
    require("mini.animate").setup({
      cursor = {
        enable = false,
      },
      resize = {
        enable = false,
      },
      open = {
        enable = false,
      },
      close = {
        enable = false,
      },
    })
  end,
}
