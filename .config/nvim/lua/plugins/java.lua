return {
  "nvim-java/nvim-java",
  dependencies = {
    "nvim-java/lua-async-await",
    "nvim-java/nvim-java-core",
    "nvim-java/nvim-java-test",
    "nvim-java/nvim-java-dap",
    "nvim-java/nvim-java-refactor",
    "MunifTanjim/nui.nvim",
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
  },
  config = function()
    -- =============== SETUP ===============
    require("java").setup({
      java_test = {
        enable = true,
        version = "0.43.0",
      },
      spring_boot_tools = {
        enable = true,
        version = "1.59.0",
      },
    })
  end,
}
