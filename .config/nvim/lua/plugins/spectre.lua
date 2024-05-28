return {
  "nvim-pack/nvim-spectre",
  config = function()
    vim.keymap.set("n", "<leader>s", '<cmd>lua require("spectre").toggle()<CR>', {
      desc = "[spectre] Toggle spectre",
    })
  end,
}
