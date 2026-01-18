return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" } },
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- =============== SETUP ===============
    require("nvim-treesitter").install({
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
      "http",
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
      "ron",
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
    })
    require("nvim-treesitter-textobjects").setup({
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_end = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
        },
      },
    })

    -- =============== VARIABLES ===============
    vim.g.indent_blankline_use_treesitter = true
  end,
}
