return {
  "saecki/crates.nvim",
  tag = "stable",
  ft = { "rust", "toml" },
  config = function()
    -- =============== SETUP ===============
    require("crates").setup({
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    })

    -- =============== MAPPINGS ===============
    vim.keymap.set(
      "n",
      "<leader>lu",
      '<cmd>lua require("crates").upgrade_all_crates()<CR>',
      { noremap = true, silent = true, desc = "[creates] Update all rust creates" }
    )
  end,
}
