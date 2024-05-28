return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    -- =============== SETUP ===============
    require("smart-splits").setup({
      cursor_follows_swapped_bufs = true,
    })

    -- =============== MAPPINGS ===============
    -- resizing splits
    vim.keymap.set(
      "n",
      "<A-h>",
      require("smart-splits").resize_left,
      { noremap = true, desc = "[smart-splits] Resize left" }
    )
    vim.keymap.set(
      "n",
      "<A-j>",
      require("smart-splits").resize_down,
      { noremap = true, desc = "[smart-splits] Resize down" }
    )
    vim.keymap.set(
      "n",
      "<A-k>",
      require("smart-splits").resize_up,
      { noremap = true, desc = "[smart-splits] Resize up" }
    )
    vim.keymap.set(
      "n",
      "<A-l>",
      require("smart-splits").resize_right,

      { noremap = true, desc = "[smart-splits] Resize right" }
    )

    -- moving between splits
    vim.keymap.set(
      "n",
      "<C-h>",
      require("smart-splits").move_cursor_left,
      { noremap = true, desc = "[smart-splits] Move left" }
    )
    vim.keymap.set(
      "n",
      "<C-j>",
      require("smart-splits").move_cursor_down,
      { noremap = true, desc = "[smart-splits] Move down" }
    )
    vim.keymap.set(
      "n",
      "<C-k>",
      require("smart-splits").move_cursor_up,
      { noremap = true, desc = "[smart-splits] Move up" }
    )
    vim.keymap.set(
      "n",
      "<C-l>",
      require("smart-splits").move_cursor_right,
      { noremap = true, desc = "[smart-splits] Move right" }
    )

    -- swapping buffers between windows
    vim.keymap.set(
      "n",
      "<A-H>",
      require("smart-splits").swap_buf_left,
      { noremap = true, desc = "[smart-splits] Swap buffer with left" }
    )
    vim.keymap.set(
      "n",
      "<A-J>",
      require("smart-splits").swap_buf_down,
      { noremap = true, desc = "[smart-splits] Swap buffer with down" }
    )
    vim.keymap.set(
      "n",
      "<A-K>",
      require("smart-splits").swap_buf_up,
      { noremap = true, desc = "[smart-splits] Swap buffer with up" }
    )
    vim.keymap.set(
      "n",
      "<A-L>",
      require("smart-splits").swap_buf_right,
      { noremap = true, desc = "[smart-splits] Swap buffer with right" }
    )
  end,
}
