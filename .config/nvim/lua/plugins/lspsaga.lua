return {
  "glepnir/lspsaga.nvim",
  config = function()
    -- =============== SETUP ===============
    require("lspsaga").setup({
      ui = {
        border = "single",
      },
      scroll_preview = {
        scroll_down = "<C-n>",
        scroll_up = "<C-p>",
      },
    })
  end,
}
