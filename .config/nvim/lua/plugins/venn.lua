return {
  "jbyuki/venn.nvim",
  config = function()
    -- =============== GLOBAL FUNCTIONS ===============
    function _G.Toggle_venn()
      local venn_enabled = vim.inspect(vim.b.venn_enabled)
      if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd([[setlocal ve=all]])
        -- draw a line on HJKL keystokes
        vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", { noremap = true, buffer = 0 })
        vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", { noremap = true, buffer = 0 })
        vim.keymap.set("n", "L", "<C-v>l:VBox<CR>", { noremap = true, buffer = 0 })
        vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", { noremap = true, buffer = 0 })
        -- draw a box by pressing "f" with visual selection
        vim.keymap.set("v", "f", ":VBox<CR>", { noremap = true, buffer = 0 })
      else
        vim.cmd([[setlocal ve=]])
        vim.cmd([[mapclear <buffer>]])
        vim.b.venn_enabled = nil
      end
    end
    -- =============== MAPPING ===============
    -- toggle keymappings for venn using <leader>v
    vim.keymap.set("n", "<leader><leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
  end,
}
