return {
  "romgrk/barbar.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    -- =============== SETUP ===============
    require("bufferline").setup({
      insert_at_end = true,
    })
    -- =============== MAPPINGS ===============
    vim.keymap.set("n", "<A-p>", "<Cmd>BufferPick<CR>", { noremap = true, silent = true })

    vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })

    vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })

    vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true })
  end,
}
