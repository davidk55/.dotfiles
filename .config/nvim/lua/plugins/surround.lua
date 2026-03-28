return {
  "kylechui/nvim-surround",
  config = function()
    -- =============== SETUP ===============
    require("nvim-surround").setup({
      surrounds = {
        ["8"] = {
          add = function()
            return { { "**" }, { "**" } }
          end,
        },
      },
    })

    -- See `:h nvim-surround.options`
    vim.g.nvim_surround_no_normal_mappings = true
    -- See `:h nvim-surround.keymaps`
    vim.keymap.set("n", "sa", "<Plug>(nvim-surround-normal)", {
      desc = "Add a surrounding pair around a motion (normal mode)",
    })
    vim.keymap.set("n", "sd", "<Plug>(nvim-surround-delete)", {
      desc = "Delete a surrounding pair",
    })
    vim.keymap.set("n", "sr", "<Plug>(nvim-surround-change)", {
      desc = "Change a surrounding pair",
    })
    vim.keymap.set("x", "sa", "<Plug>(nvim-surround-visual)", {
      desc = "Add surrounding pair to selection",
    })
  end,
}
