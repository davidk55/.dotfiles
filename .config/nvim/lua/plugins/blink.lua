return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets", "folke/lazydev.nvim" },
  version = "1.*",
  opts = {
    keymap = {
      preset = "default",
      ["<C-Up>"] = { "scroll_documentation_up", "fallback" },
      ["<C-Down>"] = { "scroll_documentation_down", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    signature = { enabled = false },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = {
          border = "rounded",
          max_height = 100,
        },
      },
      menu = {
        max_height = 100,
        border = "rounded",
        draw = {
          components = {
            source_name = {
              text = function(ctx)
                return "[" .. ctx.source_name .. "]"
              end,
            },
          },
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name", padding = 0 },
          },
        },
      },
      ghost_text = { enabled = true },
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        path = {
          opts = {
            show_hidden_files_by_default = true,
          },
        },
        lsp = {
          score_offset = 0,
        },
        buffer = {
          min_keyword_length = 4,
          max_items = 5,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
