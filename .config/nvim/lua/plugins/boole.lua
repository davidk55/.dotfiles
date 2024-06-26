return {
  "nat-418/boole.nvim",
  config = function()
    -- =============== SETUP ===============
    require("boole").setup({
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      -- User defined loops
      additions = {
        { "public", "private" },
        { "+", "-" },
        { "const", "let" },
        { "png", "svg", "jpg" },
      },
    })
  end,
}
