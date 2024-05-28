return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local api = require("typescript-tools.api")
    require("typescript-tools").setup({
      settings = {
        jsx_close_tag = {
          enable = true,
        },
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = api.filter_diagnostics({ 80001 }),
      },
    })
  end,
}
