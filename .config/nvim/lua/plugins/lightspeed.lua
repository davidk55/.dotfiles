return {
  "ggandor/lightspeed.nvim",
  init = function()
    vim.g.lightspeed_no_default_keymaps = true -- disable all default mappings of lightspeed
  end,
  config = function()
    -- =============== SETUP ===============
    require("lightspeed").setup({
      ignore_case = true,
    })
    -- =============== MAPPINGS ===============
    vim.keymap.set("n", "s", "<Plug>Lightspeed_s")
    vim.keymap.set("n", "S", "<Plug>Lightspeed_S")

    -- =============== OPTIONS ===============
  end,
}
