return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    -- =============== SETUP ===============
    require("lsp_lines").setup()
    require("lsp_lines").toggle()

    -- =============== MAPPING ===============
    vim.keymap.set("", "<Leader>ll", function()
      vim.diagnostic.config({
        virtual_text = not require("lsp_lines").toggle(),
      })
    end, { desc = "Toggle lsp_lines" })
  end,
}
