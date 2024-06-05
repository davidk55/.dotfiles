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
        background = { -- :h background
          light = "latte",
          dark = "frappe",
        },
        integrations = {
          barbar = true,
          fidget = true,
          flash = true,
          cmp = true,
          dap = true,
          dap_ui = true,
          gitsigns = true,
          illuminate = {
            enabled = true,
            lsp = true,
          },
          lsp_saga = true,
          lsp_trouble = true,
          mason = true,
          mini = {
            enabled = true,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
              ok = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
              ok = { "underline" },
            },
            inlay_hints = {
              background = true,
            },
          },
          neotest = true,
          noice = true,
          notify = true,
          nvimtree = true,
          telescope = {
            enabled = true,
          },
          treesitter = true,
          treesitter_context = true,
          ufo = true,
          rainbow_delimiters = true,
          which_key = false,
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
