return {
  "bennypowers/nvim-regexplainer",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  enabled = false,
  config = function()
    require("regexplainer").setup({
      auto = true,
    })
  end,
}
