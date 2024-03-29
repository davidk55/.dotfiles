return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "kyazdani42/nvim-web-devicons" },
  config = function()
    -- =============== SETUP ===============
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
        -- FIX: https://github.com/nvim-tree/nvim-tree.lua/issues/2057
        ignore_list = { "toggleterm" },
      },
    })
    -- =============== MAPPING ===============
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
  end,
}
