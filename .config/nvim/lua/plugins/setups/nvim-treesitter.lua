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
  },

  sync_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

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
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})
