require("colorizer").setup({
  -- filetypes where this plugin is active
  "css",
  "javascript",
  "html",
  "scss",
  css = {
    names = false,
    RGB = true,
    RRGGBB = true,
    RRGGBBAA = true,
    rgb_fn = true,
    hsl_fn = true,
  },
  scss = {
    names = false,
    RGB = true,
    RRGGBB = true,
    RRGGBBAA = true,
    rgb_fn = true,
    hsl_fn = true,
  },
})
