return {
  "kylechui/nvim-surround",
  config = function()
    -- =============== SETUP ===============
    require("nvim-surround").setup({
      surrounds = {
        ["8"] = {
          add = function()
            return { { "**" }, { "**" } }
          end,
        },
      },
    })
  end,
}
