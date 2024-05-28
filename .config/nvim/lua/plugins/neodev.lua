return {
  "folke/neodev.nvim",
  config = function()
    -- =============== SETUP ===============
    require("neodev").setup({
      library = {
        enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
        runtime = true, -- runtime path
        types = false, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
        plugins = false, -- installed opt or start plugins in packpath
      },
      lspconfig = true,
      pathStrict = true,
    })
  end,
}
