return {
  "bennypowers/nvim-regexplainer",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "MunifTanjim/nui.nvim",
  },
  enabled = true,
  config = function()
    require("regexplainer").setup({
      auto = true,
    })
  end,
}
