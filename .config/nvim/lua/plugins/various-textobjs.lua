return {
  "chrisgrieser/nvim-various-textobjs",
  config = function()
    -- =============== SETUP ===============
    require("various-textobjs").setup({ useDefaultKeymaps = false })

    -- =============== MAPPING ===============
    -- to select the key of key-value pairs
    vim.keymap.set({ "o", "x" }, "ik", function()
      require("various-textobjs").key(true)
    end)
    vim.keymap.set({ "o", "x" }, "ak", function()
      require("various-textobjs").key(false)
    end)
    -- to select the value of key-value pairs
    vim.keymap.set({ "o", "x" }, "iv", function()
      require("various-textobjs").value(true)
    end)
    vim.keymap.set({ "o", "x" }, "av", function()
      require("various-textobjs").value(false)
    end)

    -- to select the a js regex pattern
    vim.keymap.set({ "o", "x" }, "i/", function()
      require("various-textobjs").jsRegex(true)
    end)
    vim.keymap.set({ "o", "x" }, "a/", function()
      require("various-textobjs").jsRegex(false)
    end)

    -- to select a number
    vim.keymap.set({ "o", "x" }, "in", function()
      require("various-textobjs").number(true)
    end)
    vim.keymap.set({ "o", "x" }, "an", function()
      require("various-textobjs").number(false)
    end)
  end,
}
