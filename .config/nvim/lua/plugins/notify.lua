return {
  "rcarriga/nvim-notify",
  config = function()
    vim.notify = require("notify")
    -- =============== SETUP ===============
    require("notify").setup({
      timeout = 0,
    })
  end,
}
