return {
  "folke/noice.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  enabled = false,
  config = function()
    -- =============== SETUP ===============
    require("noice").setup({
      notify = {
        enabled = false,
      },
      messages = {
        enabled = false,
      },
    })
  end,
}
