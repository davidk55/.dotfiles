return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        on_highlights = function(hl)
          hl.TelescopeSelection = {
            bg = "#394b70",
          }
          hl.TelescopeSelectionCaret = {
            bg = "#394b70",
          }
        end,
      })
      -- vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
