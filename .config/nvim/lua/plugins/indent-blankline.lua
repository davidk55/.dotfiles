return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    -- =============== VARIABLES ===============
    local highlight = {
      "BlankLineColor",
    }
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "BlankLineColor", { fg = "#d3869b" })
    end)
    -- =============== SETUP ===============
    require("ibl").setup({
      scope = { highlight = highlight },
    })
  end,
}
