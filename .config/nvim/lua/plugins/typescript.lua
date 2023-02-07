return {
  "jose-elias-alvarez/typescript.nvim",
  ft = { "typescript", "typescriptreact" },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- =============== SETUP ===============
    require("typescript").setup({
      server = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          require("plugins.lsp.mappings")(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end,
      },
    })
  end,
}
