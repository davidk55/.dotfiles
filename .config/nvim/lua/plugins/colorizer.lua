return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    -- =============== SETUP ===============
    require("colorizer").setup({
      options = {
        parsers = {
          hex = {
            rrggbbaa = true, -- #RRGGBBAA (8-digit)
          },
          rgb = { enable = true }, -- rgb()/rgba() functions
          hsl = { enable = true }, -- hsl()/hsla() functions
          oklch = { enable = true }, -- oklch() function
          hwb = { enable = true }, -- hwb() function (CSS Color Level 4)
          lab = { enable = true }, -- lab() function (CIE Lab)
          lch = { enable = true }, -- lch() function (CIE LCH)
          css_color = { enable = true }, -- color() function (srgb, display-p3, a98-rgb, etc.)
          tailwind = {
            enable = true,
            update_names = true,
            lsp = {
              enable = true,
            },
          },
          sass = {
            enable = true, -- parse Sass color variables
          },
          css_var_rgb = { enable = true }, -- CSS vars with R,G,B (e.g. --color: 240,198,198)
          css_var = {
            enable = true, -- resolve var(--name) references to their defined color
          },
        },
      },
    })
  end,
}
