return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "nvim-java/nvim-java",
    "saghen/blink.cmp",
  },
  config = function()
    -- =============== SETUP ===============
    require("mason-lspconfig").setup({
      ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "dockerls",
        "docker_compose_language_service",
        "emmet_language_server",
        "gopls",
        "gradle_ls",
        "graphql",
        "html",
        "intelephense",
        "jsonls",
        "lemminx",
        "lua_ls",
        "pyright",
        "rust_analyzer",
        "sqls",
        "tailwindcss",
        "texlab",
        "yamlls",
      },
    })
  end,
}
