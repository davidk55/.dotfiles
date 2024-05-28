return {
  "folke/noice.nvim",
  dependencies = "MunifTanjim/nui.nvim",
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
