return {
  "jackMort/ChatGPT.nvim",
  enabled = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- =============== SETUP ===============
    require("chatgpt").setup({
      keymaps = {
        close = { "<C-q>" },
        yank_last_code = "<C-c>",
      },
      popup_input = {
        submit = "<C-s>",
      },
    })
    -- =============== MAPPINGS ===============
    vim.keymap.set("n", "<leader><leader>g", ":ChatGPT<CR>", { noremap = true, silent = true })
    vim.keymap.set("v", "<leader><leader>g", ":<C-u>ChatGPTEditWithInstructions<CR>", { noremap = true, silent = true })
  end,
}
