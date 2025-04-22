return {
  "mrcjkb/rustaceanvim",
  lazy = false,
  dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim", "neovim/nvim-lspconfig" },
  config = function()
    -- =============== VARIABLES ===============
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(client, bufnr)
          require("plugins.lsp.mappings")(client, bufnr)
        end,
      },
    }
  end,
}
