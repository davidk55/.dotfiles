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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local buf = args.buf
    local map = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf })
    end

    map("n", "gd", vim.lsp.buf.definition)
    map("n", "gr", vim.lsp.buf.references)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "<leader>rn", vim.lsp.buf.rename)
    map("n", "<leader>ca", vim.lsp.buf.code_action)

    -- disable formatting for specific servers
    if client.name == "lua_ls" then
      client.server_capabilities.documentFormattingProvider = false
    end
  end,
})
