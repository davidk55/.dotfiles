return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local palette = require("gruvbox").palette
      require("gruvbox").setup({
        overrides = {
          ["DapBreakpoint"] = { fg = "#993939", bg = palette.dark1 },
          ["DapLogPoint"] = { fg = "#61afef", bg = palette.dark1 },
          ["DapStopped"] = { fg = "#98c379", bg = palette.dark1 },
        },
      })
      vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank{ higroup='Visual', timeout=300 }]])
    end,
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- latte, frappe, macchiato, mocha
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        },
      })
      vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank{ higroup='Visual', timeout=300 }]])
      vim.cmd("colorscheme catppuccin")
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        on_highlights = function(hl)
          hl.TelescopeSelection = {
            bg = "#394b70",
          }
          hl.TelescopeSelectionCaret = {
            bg = "#394b70",
          }
        end,
      })
      vim.cmd([[au TextYankPost * silent! lua vim.highlight.on_yank{ higroup='Visual', timeout=300 }]])
    end,
  },
}
