return {
  "giusgad/pets.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "giusgad/hologram.nvim" },
  config = function()
    -- =============== SETUP ===============
    require("pets").setup()
  end,
}
