return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- =============== SETUP ===============
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "java",
        "lua",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "json",
        "markdown",
        "yaml",
        "vim",
        "bash",
        "comment",
        "dockerfile",
        "latex",
        "bibtex",
        "commonlisp",
        "tsx",
        "regex",
      },
      sync_install = true,

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
    -- =============== OPTIONS ===============
    vim.g.indent_blankline_use_treesitter = true
  end,
}
