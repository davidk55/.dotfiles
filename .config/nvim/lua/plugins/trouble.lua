return {
  "folke/trouble.nvim",
  config = function()
    -- =============== SETUP ===============
    require("trouble").setup({
      action_keys = {
        open_split = { "<c-s>" },
      },
    })
  end,
}
