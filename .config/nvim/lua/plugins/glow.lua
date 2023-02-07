-- FIX: `:Glow` command shows blank site on `.md` files
return {
  ft = { "markdown" },
  "ellisonleao/glow.nvim",
  config = true,
  cmd = "Glow",
}
