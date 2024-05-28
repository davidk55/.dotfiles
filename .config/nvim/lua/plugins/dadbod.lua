return {
  "tpope/vim-dadbod",
  dependencies = { "kristijanhusak/vim-dadbod-ui" },
  config = function()
    -- =============== MAPPINGS ===============
    vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { noremap = true, silent = true, desc = "[dadbod] Toggle ui" })
  end,
}
