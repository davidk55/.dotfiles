return {
  "bennypowers/nvim-regexplainer",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  enabled = true,
  config = function()
    require("regexplainer").setup({
      auto = true,
    })
  end,
}
