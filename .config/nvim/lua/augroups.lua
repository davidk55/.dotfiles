local group = vim.api.nvim_create_augroup("__env", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = ".env",
  group = group,
  callback = function(args)
    vim.diagnostic.enable(false, args.buf)
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "Cargo.toml",
  group = group,
  callback = function()
    vim.keymap.set({ "n" }, "K", function()
      if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
        require("crates").show_popup()
      else
        vim.lsp.buf.hover()
      end
    end, { noremap = true, silent = true, buffer = true, desc = "Show Crate Documentation" })
  end,
})
