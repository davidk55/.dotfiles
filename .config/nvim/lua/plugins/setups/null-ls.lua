local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.formatting.stylua.with({
      extra_args = {
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
      },
    }),
    require("null-ls").builtins.formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
    require("null-ls").builtins.formatting.google_java_format,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
        end,
      })
    end
  end,
})

-- NullLsStop command to stop null-ls
local null_ls_stop = function()
  local null_ls_client
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    if client.name == "null-ls" then
      null_ls_client = client
      vim.notify("[null-ls] null-ls is now disabled in this buffer", "info")
    end
  end
  if not null_ls_client then
    vim.notify("[null-ls] Trying to disable null-ls, hower null-ls is not active in this buffer", "error")
    return
  end

  null_ls_client.stop()
end

vim.api.nvim_create_user_command("NullLsStop", null_ls_stop, {})

-- NullLsToggle command to toggle null-ls
vim.api.nvim_create_user_command("NullLsToggle", function()
  require("null-ls").toggle({})
  vim.notify("[null-ls] Toggle null-ls between active and inactive", "info")
end, {})
