return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- =============== SETUP ===============
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = { "toggleterm" },
      },
    })

    -- =============== MAPPING ===============
    vim.keymap.set(
      "n",
      "<leader>e",
      ":NvimTreeToggle<CR>",
      { noremap = true, silent = true, desc = "[tree] Toggle nvim tree" }
    )
  end,
}
