return {
  "romgrk/barbar.nvim",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    -- =============== SETUP ===============
    require("barbar").setup({
      insert_at_end = true,
    })

    -- =============== MAPPINGS ===============
    vim.keymap.set(
      "n",
      "<A-p>",
      "<Cmd>BufferPick<CR>",
      { noremap = true, silent = true, desc = "[barbar] Pick a buffer" }
    )

    vim.keymap.set(
      "n",
      "<A-c>",
      "<Cmd>BufferClose<CR>",
      { noremap = true, silent = true, desc = "[barbar] Close a buffer" }
    )

    vim.keymap.set(
      "n",
      "<A-,>",
      "<Cmd>BufferPrevious<CR>",
      { noremap = true, silent = true, desc = "[barbar] Select previous buffer" }
    )
    vim.keymap.set(
      "n",
      "<A-.>",
      "<Cmd>BufferNext<CR>",
      { noremap = true, silent = true, desc = "[barbar] Select next buffer" }
    )

    vim.keymap.set(
      "n",
      "<C-,>",
      "<Cmd>BufferMovePrevious<CR>",
      { noremap = true, desc = "[barbar] Move current buffer to the right" }
    )
    vim.keymap.set(
      "n",
      "<C-.>",
      "<Cmd>BufferMoveNext<CR>",
      { noremap = true, silent = true, desc = "[barbar] Move current buffer to the left" }
    )
  end,
}
