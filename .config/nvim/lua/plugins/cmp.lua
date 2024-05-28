return {
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  event = "InsertEnter",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      local kind_icons = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      }

      vim.o.completeopt = "menu,menuone,noselect"

      -- =============== SETUP ===============
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              local key = vim.api.nvim_replace_termcodes("<C-r>+", true, false, true)
              vim.api.nvim_feedkeys(key, "n", false)
            end
          end,
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end,
        },
        sources = cmp.config.sources({
          { name = "luasnip" },
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer", keyword_length = 4 },
          { name = "calc" },
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- Source
            vim_item.menu = ({
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              path = "[Path]",
              calc = "[Calc]",
            })[entry.source.name]
            -- apply tailwind color icons
            vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
            return vim_item
          end,
        },
        -- disable cmp when writing comments
        enabled = function()
          -- disable completion in comments
          local context = require("cmp.config.context")
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == "c" then
            return true
          else
            return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
          end
        end,
      })
    end,
  },

  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-calc",
  "hrsh7th/cmp-nvim-lsp-signature-help",
}
