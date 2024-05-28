return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- =============== SETUP ===============
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "bibtex",
        "c",
        "cmake",
        "comment",
        "commonlisp",
        "cpp",
        "css",
        "csv",
        "dockerfile",
        "gitcommit",
        "go",
        "graphql",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "html",
        "kconfig",
        "kotlin",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
        "php",
        "phpdoc",
        "properties",
        "printf",
        "python",
        "regex",
        "rust",
        "query",
        "scss",
        "sql",
        "ssh_config",
        "tmux",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
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
      indent = {
        enable = true,
        disable = {
          "markdown",
        },
      },
      highlight = { enable = true, disable = { "latex" } },
    })

    -- =============== VARIABLES ===============
    vim.g.indent_blankline_use_treesitter = true
  end,
}
