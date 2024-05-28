return {
  "jbyuki/venn.nvim",
  config = function()
    -- =============== GLOBAL FUNCTIONS ===============
    function _G.Toggle_venn()
      local venn_enabled = vim.inspect(vim.b.venn_enabled)
      if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd([[setlocal ve=all]])
        -- draw a line on HJKL keystrokes
        vim.keymap.set("n", "J", "<C-v>j:VBox<CR>", { noremap = true, buffer = 0, silent = true, desc = "[venn] Down" })
        vim.keymap.set("n", "K", "<C-v>k:VBox<CR>", { noremap = true, buffer = 0, silent = true, desc = "[venn] Up" })
        vim.keymap.set(
          "n",
          "L",
          "<C-v>l:VBox<CR>",
          { noremap = true, buffer = 0, silent = true, desc = "[venn] Right" }
        )
        vim.keymap.set("n", "H", "<C-v>h:VBox<CR>", { noremap = true, buffer = 0, silent = true, desc = "[venn] Left" })
        -- draw a box by pressing "f" with visual selection
        vim.keymap.set("v", "f", ":VBox<CR>", { noremap = true, buffer = 0, silent = true, desc = "[venn] Draw" })
        vim.notify("[venn] Enable venn", vim.log.levels.INFO)
      else
        vim.cmd([[setlocal ve=]])
        vim.cmd([[mapclear <buffer>]])
        vim.b.venn_enabled = nil
        vim.notify("[venn] Disable venn", vim.log.levels.INFO)
      end
    end

    -- =============== MAPPING ===============
    -- toggle keymappings for venn using <leader>v
    vim.keymap.set(
      "n",
      "<leader><leader>v",
      ":lua Toggle_venn()<CR>",
      { noremap = true, silent = true, desc = "[venn] Toggle venn" }
    )
  end,
}
