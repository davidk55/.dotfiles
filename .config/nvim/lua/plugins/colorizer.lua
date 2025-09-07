return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    -- =============== SETUP ===============
    require("colorizer").setup({
      user_default_options = {
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        tailwind = "both", -- Enable tailwind colors
        tailwind_opts = { -- Options for highlighting tailwind names
          update_names = true, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
        },
        sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
      },
    })
  end,
}
