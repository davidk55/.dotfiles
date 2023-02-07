return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = "ellisonleao/gruvbox.nvim", -- makes sure that the colors are loaded from the theme
  config = function()
    vim.cmd([[highlight IndentBlanklineContextStart guisp=#FF0000 gui=underline]])
    -- =============== SETUP ===============
    require("indent_blankline").setup({
      -- show a vertical line that marks the current scope
      show_current_context = true,
      -- show a horizontal line of the beginning of the scope
      -- show_current_context_start = true,
    })
  end,
}
