return {
  "nvim-java/nvim-java",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- =============== SETUP ===============
    require("java").setup()
    vim.lsp.enable("jdtls")
  end,
}
