return {
  "williamboman/mason.nvim",
  config = function()
    -- =============== SETUP ===============
    require("mason").setup({
      registries = {
        "github:nvim-java/mason-registry",
        "github:mason-org/mason-registry",
      },
    })

    -- =============== MAPPINGS ===============
    vim.keymap.set(
      "n",
      "<leader><leader>m",
      ":Mason<CR>",
      { noremap = true, silent = true, desc = "[mason] Open mason" }
    )
  end,
}
