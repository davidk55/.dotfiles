return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    -- =============== SETUP ===============
    require("smart-splits").setup({
      cursor_follows_swapped_bufs = true,
    })

    -- =============== MAPPINGS ===============
    -- resizing splits
    vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)

    -- moving between splits
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

    -- swapping buffers between windows
    vim.keymap.set("n", "<A-H>", require("smart-splits").swap_buf_left)
    vim.keymap.set("n", "<A-J>", require("smart-splits").swap_buf_down)
    vim.keymap.set("n", "<A-K>", require("smart-splits").swap_buf_up)
    vim.keymap.set("n", "<A-L>", require("smart-splits").swap_buf_right)
  end,
}
