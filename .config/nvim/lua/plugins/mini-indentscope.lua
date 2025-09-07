return {
  "nvim-mini/mini.indentscope",
  config = function()
    -- =============== SETUP ===============
    require("mini.indentscope").setup({
      options = {
        -- Type of scope's border: which line(s) with smaller indent to
        -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
        border = "both",

        -- Whether to use cursor column when computing reference indent.
        -- Useful to see incremental scopes with horizontal cursor movements.
        indent_at_cursor = false,

        -- Whether to first check input line to be a border of adjacent scope.
        -- Use it if you want to place cursor on function header to get scope of
        -- its body.
        try_as_border = false,
      },
      symbol = "│",
    })

    -- =============== AUTOCOMMANDS ===============
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
        "NvimTree",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
      desc = "Disable mini-indentscope for several filetypes",
    })
  end,
}
