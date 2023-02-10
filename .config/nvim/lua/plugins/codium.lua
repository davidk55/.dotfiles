return {
  "Exafunction/codeium.vim",
  ft = { "html", "css", "typescript", "typescriptreact", "javascript", "javascriptreact", "java" },
  enable = false,
  config = function()
    vim.keymap.set("i", "<M-CR>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true })
    vim.keymap.set("i", "<M-]>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true })
    vim.keymap.set("i", "<M-[>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true })
    vim.keymap.set("i", "<M-BS>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true })
  end,
}
